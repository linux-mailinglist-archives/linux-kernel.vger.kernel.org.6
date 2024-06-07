Return-Path: <linux-kernel+bounces-205751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35A8FFFCA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7041F26E59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0715B98F;
	Fri,  7 Jun 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DdUoUPH"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FB15B13C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753415; cv=none; b=I0B0nMjcaz1bGak5Ngd1TXryJtVehV32SdPlq7X5f/qrRx3qMwpNRogerZhfHfgZKwEGzuHqRE33GjFf1hNcR3dUsN98dk5oXSc5nlQskjZMBxSD0f7kgM9+i1p1gysGJN+qJkleyz38gIoQhLAgNo0OFoRm/EwFoBNdPcUMsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753415; c=relaxed/simple;
	bh=VeVSJnLlRH/miBgW1vozdVuS6TLtZvGfRxG/7G2ETMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZowLDC5FAY1wC9eBO61Q+YbdqeDPGh18k+LbJ3AjdsJQj2g6QF+qHF4VzDBYcU9dkRyxAgxdW2r28/2IpR0M9+LfjDAzlIdGQf+zjxh27UWePlyTqQ8I0VddHD8Rr8XpoAjnf3GWwTtkA6c8aOKEo09QuuW+BQddEl/rhBuEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DdUoUPH; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-52bc277a9f7so72244e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717753412; x=1718358212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/YN8NbApmrplnThMGLuKQX7kmaVgfISdJYXyZPraf4=;
        b=0DdUoUPHWOp7ZOsnqYmoChdqHZqsExA2MyNEVGWixSYqX3UcTEOTc7V9GkhQaQ8iN7
         3atmRcyIxD5Hh71jFvaFKJuCg44lZrQb+G0Ile8ylbcfj1ysnuvickT7J15bo35Dhe/K
         MWD6Tx3a/tvHPnH2qPGk3z/dEEl8XNqvXbEbVlArsj9J6kX0NjJirfQ4qeZdb5tqh4T1
         i6f/1Rc9jdoDFXqS7MwNxKQOEKA2usYgBJJ6rjl9KW9/T/hIB/kUO4k02eQNRAck8Xr4
         KWvog0ujEWXfUtLKZfADgpzUQvde1T1kVlwkQ53MJGIo1EVq+addxotUgB4gxNwSscFy
         U2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753412; x=1718358212;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/YN8NbApmrplnThMGLuKQX7kmaVgfISdJYXyZPraf4=;
        b=jCAT7ZxiNO79Fajz6N+IMSaFe2OkLnSO6VtwPWsLNd5B4WFRapr7z275caG8CYdrwR
         7EX0v294RjQM+xKfo/xodF0PlIVNcEGpPzZHMzv92XXcQyjb2qnSdEzMnEGV2G32K1KD
         Thkh/mS+IE9xt+tvuFJKbipghY8Xe2Ah7x3WXiYmldGuXeMXLhoXKFgmLO76ekMSq0fk
         4dU47zYjupLM7tyRKHzJKesmOj6q9y100cKeXWaDmVB4x5OB+rYxKjY/HkCqplHksdmF
         UjapeC+s2LGudb5aIA4v8DplnlBLQmiGYMjy4XQ26yEVOcdTL5bbTjBsPXL+0oVpIXgF
         dHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs60wWQyn+PBu5eNtJM8PV7ulkt9v4d0jFw7sKkQLEAJGr1MMQpmzxTIsNcboOW3uoGLQ33VPZR2cZD+d2ojq9/X120vKXWBy5nQ0h
X-Gm-Message-State: AOJu0YwIJcx5L9gKT6FGd3IsNv2/iuyrx0hCKU/ozjpAgqGXTwNjY0wp
	uObamGV/013vIWfYOeN3N8iyPfvbEq443s/gzvGUuuPPBjfWZBEXMzgZCKoiYXGGL1iRh2Y4R6q
	K3tQY7IQExyn6XA==
X-Google-Smtp-Source: AGHT+IE7NAXSKHEZJR73S0J+KkqobFZvO93f/V0dPMCOMhXIEXFB0cuBoB/UlBUY6YBl7cWQkLstuSti/tQ9kp8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:5687:0:b0:52b:7a59:5199 with SMTP id
 2adb3069b0e04-52bb9fcb16amr2622e87.11.1717753412145; Fri, 07 Jun 2024
 02:43:32 -0700 (PDT)
Date: Fri,  7 Jun 2024 09:43:29 +0000
In-Reply-To: <20240606193318.GK8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240606193318.GK8774@noisy.programming.kicks-ass.net>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607094329.3878781-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/3] rust: add static_call support
From: Alice Ryhl <aliceryhl@google.com>
To: peterz@infradead.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	ardb@kernel.org, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, jbaron@akamai.com, 
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org, 
	rostedt@goodmis.org, rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Jun 06, 2024 at 09:09:00PM +0200, Miguel Ojeda wrote:
> > On Thu, Jun 6, 2024 at 7:19=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > This is absolutely unreadable gibberish -- how am I supposed to keep
> > > this in sync with the rest of the static_call infrastructure?
> >=20
> > Yeah, they are macros, which look different from "normal" Rust code.
>=20
> Macros like CPP ?

Yes, this patch series uses declarative macros, which are the closest
that Rust has to the C preprocessor. They are powerful, but just like
CPP, they can become pretty complicated and hard to read if you are
doing something non-trivial.

The macro_rules! block is how you define a new declarative macro.

The ($name:ident($($args:expr),* $(,)?)) part defines the arguments to
the declarative macro. This syntax means:

1. The input starts with any identifier, which we call $name.
2. Then there must be a ( token.
3. Then the $(),* part defines a repetition group. The contents inside
   the parenthesises are what is being repeated. The comma means that
   repetitions are separated by commas. The asterisk means that the
   contents may be repeated any number of times, including zero times.
   (Alternatives are + which means repeated at least once, and ? which
   means that the contents may be repeated zero or one time.)
4. The contents of the repetition group will be an expression, which we
   call $args.
5. After the last expression, we have $(,)? which means that you can
   have zero or one commas after the last expression. Rust usually
   allows trailing commas in lists, which is why I included it.
6. And finally, you must close the input with a ) token.

So for example, you might invoke the macro like this:

static_call!(tp_func_my_tracepoint(__data, &mut my_task_struct));

Here, $name will be tp_func_my_tracepoint, and the repetition group is
repeated twice, with $args first corresponding to `__data` and then to
`&mut my_task_struct` when the macro is expanded. The $(,)? group is
repeated zero times.


Inside the macro, you will see things such as:
$crate::macros::paste! { $crate::bindings:: [<__SCK__ $name >]; }

The Rust syntax for invoking a macro has an exclamation mark after the
name, so you know that $crate::macros::paste is a macro. The `paste`
macro just emits its input unchanged, except that any identifiers
between [< and >] are concatenated into a single identifier. So if $name
is my_static_key, then the above invocation of paste! emits:

	$crate::bindings::__SCK__my_static_key;

The $crate::bindings module is where the output of bindgen goes, so this
should correspond to the C symbol called __SCK__my_static_key.

> > Is there something we could do to help here? I think Alice and others
> > would be happy to explain how it works and/or help maintain it in the
> > future if you prefer.
>=20
> Write a new language that looks more like C -- pretty please ? :-)
>=20
> Mostly I would just really like you to just use arm/jump_label.h,
> they're inline functions and should be doable with IR, no weirdo CPP
> involved in this case.

I assume that you're referring to static_key_false here? I don't think
that function can be exposed using IR because it passes the function
argument called key as an "i" argument to an inline assembly block. Any
attempt to compile static_key_false without knowing the value of key at
compile time will surely fail to compile with the

	invalid operand for inline asm constraint 'i'

error.

Alice

