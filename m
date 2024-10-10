Return-Path: <linux-kernel+bounces-359199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C819C99889A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876D82895DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49FA1C9DFC;
	Thu, 10 Oct 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qd3BtDhu"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9D1C7B6A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568907; cv=none; b=EQNWhEiFR1QTAH05KuKz/SmH+roFOwBfrHQVDNJ1Gm6jJI06hzKv1D26hZpiTvAeU5tjB1b5CXviJJxO4jCIx7EZB3ed5PN2TltxUoIInTE2EfZGLTEWWhGZZDc4bIa6yt3eZ2q8aXjP/M424VOSoRXcW0TSfLoRGZ2VJA74TIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568907; c=relaxed/simple;
	bh=kALkcQRrhntN1yB20faxRzZG0b1HvvZgGUychwJTUIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNuim1Ffj3rKBXse+v2LQ10CO3+MNTVSLqPDiUhqf5sfKiBzLNmhpdb0VJrlSNJICvK3OshH6vfNFBRLpCIlzy3Yzi8rxYcke7pQogjvU5luUnVpFXM7mibWNJOSdAaU7mbXdMuJHgBwcT91WS949oNKi1VgLdEfkC/5MuLf9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qd3BtDhu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d47b38336so541081f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728568904; x=1729173704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3CizW4u3+UrLWSR0ffHUPIJ13PdM9vRjZPunNir5Hg=;
        b=qd3BtDhuhekoxfW5j979y9b73Q2YXdYrtICznhDXDyGu6kGBiDp/lMKBjRkOCXFihI
         DLmT1vWo8ya+6qGSxeZKQo20Ju0Vv7hDNjW87xJMCR33PydrWe+fTPSLqv34UerLEDzv
         6XYNJcc7fyT5J5QxhhuBjkgYyqRb6jHhcsUCG6TkzBqeZ9lRJOxz8FgPnZJE+U2HJq1v
         zbdrqPA9cLGDJfHjyzPN6jujQV/prwuq2NxoJbyp4D6dMJNO5GmtG2+h6OSwUXoDGTK6
         CaDEUoXLPnS6FU1VaautmTkDwQWQX1tldjmSJwKJn+Mymgc2j+PdbyBHkzgBM9sIX0Y5
         ZRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568904; x=1729173704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3CizW4u3+UrLWSR0ffHUPIJ13PdM9vRjZPunNir5Hg=;
        b=JF9xFz5nFuNllFZLW5teUqsWXJzrFqrSF+Z6mMixw/7IT6AW67qzgt4esw7fezY6ba
         UfB/Qo9oiCzKyntw9t0Bx7dui+dienEAvbaZYTRdIKz9eW2q8Ib/bp2uu6jAVC3awUEY
         rxiLB0PrLovZpUPyWMol+zGLJwj+itK5KlAobGt5uJyCENO+Bi1pEi6rYd4/FPbCnek+
         rJGhnY4gHDuEyASlJPMMOYgehg0Y/rIAyqvB+jeWmXmFjDUuhVOhIQD99sqbbRwZCk3V
         OS268zkFOjXDyB3jZktDUp/Z47VasBe2kpv4O1TMJy//7BG79+A63GkTUcIondVuFrJZ
         2w1w==
X-Forwarded-Encrypted: i=1; AJvYcCVsHGWvIhEx+1gXVixm+8bRzGj/sxiZwEufd145nmRcSzYB2U4nTKNTD448RqEk/pLgZA2jJgFMN8YmS6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RrXVvM/nAPFJ92lndwS0GsJf+/UjRmrfXXZukTd23ZKxV34S
	UPp/i2hzChm6/cBdfqzNgGDIaGY+bAep9fDmA0qa4B54JsQ0yRaxmrjX9ZzAjTImcmBZqu5dlp/
	LfYDBikh/yraXtAucYBJS6h0WUd/qQBMufS/g
X-Google-Smtp-Source: AGHT+IGbl/myGulPH7utUVANwqGBZ1G1wJDyWXE9tQCoFt9Nv3IiGyF+ktDEcfU32Dohut4keUWPmBaXOt/2BJpg4ck=
X-Received: by 2002:adf:e592:0:b0:37d:4956:b0b4 with SMTP id
 ffacd0b85a97d-37d4956b4a4mr1614858f8f.59.1728568903205; Thu, 10 Oct 2024
 07:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-static-mutex-v4-1-c59555413127@google.com> <87r08okqlp.fsf@kernel.org>
In-Reply-To: <87r08okqlp.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Oct 2024 16:01:29 +0200
Message-ID: <CAH5fLghvZsU-rF+6hkOoiAOWhpiLJV1WJNPYCRWTq7cEW8UM1w@mail.gmail.com>
Subject: Re: [PATCH v4] rust: add global lock support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:57=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Hi Alice,
>
> Alice Ryhl <aliceryhl@google.com> writes:
>
> > Add support for creating global variables that are wrapped in a mutex o=
r
> > spinlock. Optionally, the macro can generate a special LockedBy type
> > that does not require a runtime check.
> >
> > The implementation here is intended to replace the global mutex
> > workaround found in the Rust Binder RFC [1]. In both cases, the global
> > lock must be initialized before first use. The macro is unsafe to use
> > for the same reason.
> >
> > The separate initialization step is required because it is tricky to
> > access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
> > require changes to the C side. That change will happen as a follow-up t=
o
> > this patch.
>
> Why is this a challenge? It seems to work with locks that are not
> global.

Because normal locks are not initialized in a const expression.

> > diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/gl=
obal.rs
> > new file mode 100644
> > index 000000000000..fc02fac864f6
> > --- /dev/null
> > +++ b/rust/kernel/sync/lock/global.rs
> > @@ -0,0 +1,260 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Support for defining statics containing locks.
> > +
> > +/// Defines a global lock.
> > +///
> > +/// Supports the following options:
> > +///
> > +/// * `value` specifies the initial value in the global lock.
> > +/// * `wrapper` specifies the name of the wrapper struct.
>
> Could you add an example to demonstrate when using `wrapper` option
> would be useful?

Probably only guard and locked_by are useful, but I think you need to
give the wrapper a name to reasonably use guard/locked_by.

> > +                    /// Lock this global lock.
>
> "Try to lock..." ?

Thanks. Good point.

Alice

