Return-Path: <linux-kernel+bounces-353508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B6992EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA5E285185
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D41D90DF;
	Mon,  7 Oct 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcPqXvXc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518801D7992
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310622; cv=none; b=oZv0WNSFzA270Xgt0/H6TZBI2rL+73AVk6/zqM0mVYI3odhoBZ2gptnMZBwKmWOjf61llcypHm+xXPbHaDf3Tdx49c8I+oQJadjqL7xH3F9IW79Qajrlgtft2lYfV7rtTfF2Ytq5jQEmuk6PV+43IrcUZfqE2y90WQgow0yhLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310622; c=relaxed/simple;
	bh=376HqnvNhc5ZE0HBO6XE8aIeQfBue1EBUdnGFKgW028=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvUXCh/gdxISXlJpsuJzssV2+P0qll+jWzcrKb+UX1d7YjgI+W0HhjHzdfQwQNlV2DGSoLXejpFgM/xSot4ehE6AgJOhe4cfh4CJ0rHrlVJhqTJhOLbIeDLrnIWup1yNqbmisSQ2e1yhoqUuoI2gFEYSPf/2WbhZcjemZ3b0YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcPqXvXc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so438947b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728310620; x=1728915420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZotRyJfqUBQUUh0GdjsSXNxbz4lowqfUZ4/U9osmyA=;
        b=fcPqXvXcxEMkgbz11ctygKKwnEzhK4OL6i+PhJxnCrinRC0LpMtkgD474UtFJ8nzk6
         1gPNyUmT3eq+xh6i33Ku1F623wDtyk7LwLwF8VWRHpKlSZnOcIZ7pNmGvwAu5CMFhwmF
         nURwmfU7OJhF5IQHAS8jPhxl3JZoULmxqDhzHpCkdE8UlPD3Zs5rJpKJbFeDBfPf4aHZ
         uMIgGQICxCjO8CTGyfTYIqpmsj2PborSN3a7N5EksxSfUN0tXpCPrdfCdikpRrsCBu7+
         9F1Qz0JRV22GyCSgw3l4nmlfGdZYClqA+29rhA2l3CAa/zEi6qVRHzMwzx3p1nPqi5VR
         Om2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310620; x=1728915420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZotRyJfqUBQUUh0GdjsSXNxbz4lowqfUZ4/U9osmyA=;
        b=Avves/qMlF8bUuO/1pSl6aZXxzcLtu0r4qp7WSG7JepvHsG5/xpP7OCgEgCsBNopFK
         3Z/CIDxyZ7zv1GluOJMIia6w+/gvzG1nrr6z0hA/Mv9yEHeNTyKGXMESk0yB6n8G0wjf
         cTaxfT3PUlOBbjgq1VCc3lOF9zQBpVpl4jiF85VwRQYXlnREKEdl22nozWuNdZBeMyK2
         IgVEy2FLSSrK1KMqCHTywTHlNPT/QEgvdtP6YxIqBNy0KU8mDxQv+HxIowhGe7x/gJ+/
         n8P4vglpNATw0oZXjZzLBl1eNp+Svg0p4ngRLXnW27ukrt8Ny15uXGPZnVoFxHsRDikL
         CYYw==
X-Forwarded-Encrypted: i=1; AJvYcCW49e/lFOqqiECrsS2QqJZXpV7UeOQzphD3TCD2tQwCEXHkm9/0Hda3ysIZPB2G/Xdl/VnBNELI94teaM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4Rs1h1047527cAGPiQaFkNZ+u4zisI9f0zswOawEWdbDrbCR
	DjMT59Fav/LOq2dQTZylwC0qjWDzBh3PQw9S7ngHC7kPlnJcXG0b5I7h1W9JHCb1ox7kNbDPmBH
	9S1VmE7lElvjAoUpB5HHT0CuDRrnbSKVdF9fW
X-Google-Smtp-Source: AGHT+IGRirQUTUs43IAYcReXl0EvbBGWtade4ytNJlT9/pAyB7YZGBvddZQaFl4GNDeiuwukPx5yEImABPr95O01a0M=
X-Received: by 2002:a05:6a20:29a7:b0:1d6:e593:1d6b with SMTP id
 adf61e73a8af0-1d6e5931deamr10398837637.6.1728310620266; Mon, 07 Oct 2024
 07:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com> <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux> <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux> <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com> <ZwPsdvzxQVsD7wHm@boqun-archlinux>
In-Reply-To: <ZwPsdvzxQVsD7wHm@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 16:16:46 +0200
Message-ID: <CAH5fLgigW6STtMBxBRTvTtGqPkSSk+EjjphpHXAwXDuCDDfVRw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:14=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Mon, Oct 07, 2024 at 04:08:48PM +0200, Alice Ryhl wrote:
> > On Mon, Oct 7, 2024 at 3:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> > > > On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> > > > However, this is actually a special case: currently we want to use =
klint
> > > > [1] to detect all context mis-matches at compile time. So the above=
 rule
> > > > extends for kernel: any type-checked *and klint-checked* code that =
only
> > > > calls safe Rust functions cannot be unsafe. I.e. we add additional
> > > > compile time checking for unsafe code. So if might_sleep() has the
> > > > proper klint annotation, and we actually enable klint for kernel co=
de,
> > > > then we can make it safe (along with preemption disable functions b=
eing
> > > > safe).
> > > >
> > > > > where you use a sleeping function in atomic context. Depending on=
 why
> > > > > you are in atomic context, it might appear to work, until it does=
 not
> > > > > actually work, and bad things happen. So it is not might_sleep() =
which
> > > > > is unsafe, it is the Rust code calling it.
> > > >
> > > > The whole point of unsafe functions is that calling it may result i=
nto
> > > > unsafe code, so that's why all extern "C" functions are unsafe, so =
are
> > > > might_sleep() (without klint in the picture).
> > >
> > > There is a psychological part to this. might_sleep() is a good debug
> > > tool, which costs very little in normal builds, but finds logic bugs
> > > when enabled in debug builds. What we don't want is Rust developers
> > > not scattering it though their code because it adds unsafe code, and
> > > the aim is not to have any unsafe code.
> >
> > We can add a safe wrapper for it:
> >
> > pub fn might_sleep() {
> >     // SAFETY: Always safe to call.
> >     unsafe { bindings::might_sleep() };
>
> It's not always safe to call, because might_sleep() has a
> might_resched() and in preempt=3Dvoluntary kernel, that's a
> cond_resched(), which may eventually call __schedule() and report a
> quiescent state of RCU. This could means an unexpected early grace
> period, and that means a potential use-afer-free.

Atomicity violations are intended to be caught by klint. If you want
to change that decision, you'll have to add unsafe to all functions
that sleep including Mutex::lock, CondVar::wait, and many others.

Alice

