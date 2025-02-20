Return-Path: <linux-kernel+bounces-524639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A23A3E557
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4532216A679
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2252262D3D;
	Thu, 20 Feb 2025 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDU2D95w"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630401B423B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080944; cv=none; b=BhXRnMhwnh+bI1MFusv5aJBaZ2B89OBRP13KB/gDxjJRgxgbM6cxkaxaoBgRWhSMBBrpk0Zb0CHlq1j07PRWhM4/1miqWNWbbf3APTruZWzC9XdJC47n4gqy5K45x5GiVTh5kL3ZbOoxsmqx2ANFGqxIUDIvxtcA/7CSxExqv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080944; c=relaxed/simple;
	bh=rA0Kwp16xeeS5LZ0BAYWfUuav/tin7pCBKweDIt+JDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqslEbeSemxIGu3KZV1DvN1TTLKYJj08eU+eH/pdUVOdxtf27/KjLf89Q8GKY4TK2AK6DzTSPCwAWYq6mYL9nKSAslbgnQVk08Pxjh/XicSAmxTLqsS2jNDEtVWaK0Z/+4sI1Z1jvToL3oO8If2IUtMXL8psHROT+2/nmRmQeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDU2D95w; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so8852595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740080941; x=1740685741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA0Kwp16xeeS5LZ0BAYWfUuav/tin7pCBKweDIt+JDg=;
        b=IDU2D95wuGSE/yigRn1TH4y4aiizsQMowCXbqHlV2QRvKgPjCoB1VLpeE90a8AQQtG
         r4Ned7tLH5XIgluAbEv8QS/SdB6C7aWwfn9AbFf6DdqoGJEZfMRQauJMd/plWLq3IuoY
         OKWAtVlOnEhYgIJfCE8miJjq5/8y47txTUszVT7mBxBk57SnGl6GtiamPtpt88C8yb6l
         U/oZQFLUnWDN0iEtvtAWc3cOo9ID0j72oqeYtuPkNCGVvTwappKxgcVrtVwJsGg7+ZPI
         13mwrxi6O/yvQJ4pEVG+1jRJ8ci02D1bdetNoT8bygH94HL1VThxQ3Y4QmeXPErhTQu4
         u4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080941; x=1740685741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rA0Kwp16xeeS5LZ0BAYWfUuav/tin7pCBKweDIt+JDg=;
        b=s70fAhA0BBr1S8hz6lLsjEugKlOf3PiqBi8+AGoHoCk5gmX7cqtG1ClxZOios4wj6R
         VejQBVQLLFd8QzFeFQkE8j3CsSsW/NnTHhhxsjHGjUwcpmjBVECLJxGQGFRLJ5vuoO7/
         JhnYk68CWY48Xu5Z94VVNzZtVv561xyA6bMkWiA/Bo8bGbPdKIJp7pWIi6G0hMjMv+Ik
         isihhFkUM3fVOI+ftYMGEqhOyI8oeeipK/uGC4q8rrSKFuK4/ahitQer0MT+jnM+qXAS
         76FQrl16yZGGOve2SabOJ0gcepnKAqasihPGFwIwiQlAcTTuGb8WZexDApxje5m+5KQ4
         7KOw==
X-Forwarded-Encrypted: i=1; AJvYcCWbNO0zFMfbwV4jZsobkfvX/VyxTxrls2+3ke5BzCMNx+/W1tschAViH+9gvOGIry+h2YoTiqTei31E7cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrr8Lg0IoZIgtHoIQjvjcueScpVkngJ++YoKbFzPjRistrxwqu
	+4MRjsRxi5WeHBZ0OM8q5VJxrLecn78pmOvefRzMktYL2whxXd6bJB3sYaGyuOCrhKui+R7sfhf
	gMOBfIjgK/OP64RY73JsgeS7diXC06SaI5Nek
X-Gm-Gg: ASbGncsSVkFSOXQlNyhz7HRP8C64eGdIXuXMp8IxHaiWSYR4DAht9Cnlxc1tDfqTzRL
	8/ilgk0cbwJg44Bc1/fME8dwFw2LPmzXMyXw6EiAtP4PAqucg1iW2GnWZmAF6Vlf/evoX7d7B
X-Google-Smtp-Source: AGHT+IHsln79wPXKAWyhMpVjNEVQXJOEfV3EjLn1vu36fg+0aATwmiU66VTWmmNBOeV+D4kqoTots+5AOWDkCwXqDGk=
X-Received: by 2002:a05:600c:3b93:b0:439:96b2:e9b with SMTP id
 5b1f17b1804b1-439ae1e6a3amr3860425e9.9.1740080940624; Thu, 20 Feb 2025
 11:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-cstr-core-v8-0-cb3f26e78686@gmail.com>
 <CAJ-ks9kyozt45VeXG7GBTN-ejy_HGMOekFYFMmzS8AbEusZMWQ@mail.gmail.com>
 <CAH5fLgjUuCo5Ayx4WCfnrVAC1prvUbY-pvZdinkAb+KcSOWvpA@mail.gmail.com> <CAJ-ks9=JMWQMTdJSkdVGJus1mcRQWZ-34B_s4Ti7ab5NAdA6pg@mail.gmail.com>
In-Reply-To: <CAJ-ks9=JMWQMTdJSkdVGJus1mcRQWZ-34B_s4Ti7ab5NAdA6pg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 20 Feb 2025 19:48:48 +0000
X-Gm-Features: AWEUYZntgDVdVP1SJ-D0umjAVRTDDGHObfW5v-Y7ttmdAu1IfOZB5UZocBar5Hw
Message-ID: <CAH5fLgjnYrfqmsv+nFpBr=cNHosfzY2VRzVU=Zn_PwPe8Ww=0g@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Tamir Duberstein <tamird@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Feb 19, 2025 at 9:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Tue, Feb 18, 2025 at 5:05=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> > >
> > > Gentle ping. Trevor, Alice, Benno: you all participated in the last
> > > round of review - I'd appreciate it if you could take a look at this
> > > series.
> >
> > The primary thing that comes to mind looking at this is that losing
> > the Display impl is pretty sad. Having to jump through hoops every
> > time you want to print a string isn't great :(
>
> There's the practical answer and the philosophical one. The former is
> that core::ffi::CStr doesn't impl Display. The latter is that Display
> implementations aren't meant to be lossy, and we shouldn't make it
> ergonomic to do things that might surprise the user.

I don't think there's any problem with a lossy Display impl. It's
supposed to be user-facing, and that's more or less what it requires.
Does kernel printing even require the string to be utf-8 in the first
place? I guess there's a mismatch about that here.

> We could add our own UnicodeCStr which could impl Display and be
> AsRef<CStr>. Do you think that should gate this work?

The solution I actually want is just for CStr to be Display, but
that's not something we can control on the kernel-side. I won't block
this change over it.

Alice

