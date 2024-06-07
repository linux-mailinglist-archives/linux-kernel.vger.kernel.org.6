Return-Path: <linux-kernel+bounces-205873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2A9001A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C39D1C21A63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A67188CAB;
	Fri,  7 Jun 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gH4Gbsz0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7218734C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758521; cv=none; b=QFo1/O2SrhCmPXRPbBpIPINiOOBMra0MGcRzQCYp5qwVxUiQTZTo6KtChfSthvRUs/VnbsezYrski9z3Vuw+HkVgrpe7UgZimcVIHmK5ba8op5spvBAiw2ItiGs+wajZEh/yrPysVIFuP3kLpUalvXXh/xo2P2K8upeA7xQ1PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758521; c=relaxed/simple;
	bh=oyhlSsZ9u9jea1W+2i6eZUOvz1sTt2oMZhFdHqZNdTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJ5Ha4oN9lC3R938/2tmsp0WsVwydXRJBIGjkNBBKDaSFvfpeKegLlNyQ0/Part5QQcz7GckLw17F4HN37PQ/bGRgfNSd1BmpJQqfTcvi2s3fV22awdzRn1IBzVBbTqamWAafgxFOsz6PCHluRNA5gdVwpO0Gp9wSyJxKWgPSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gH4Gbsz0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-356c4e926a3so1865186f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717758518; x=1718363318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nK7eNQ+hoX2l5wdTyQQ8AV5LulVt/l/ya99NvQfTdM=;
        b=gH4Gbsz01CLU+qqGp62pq4ARD9t9VcIVrXFI29L84aeKfnFGQ2MJyA2Kldh3iyl2YJ
         NzYVgucvTII3CyresLN7OCRGAXUq8wLQsUpXbY2+M4cQNPjMeps6y/lweGDLy1XmM7Ur
         cpGae86RQKqJ/d9cub//wKyVg6rMUHsmUvCgeXco+Njb1yZAzUTqcVRtObZ5Wd/utXnf
         tOBQ9mk1gDl9zoDVHLM1ak5sMrPImIjIP707aSB+rBJeIhzK90K7OtDY8ysi324ln7Z0
         THZkdDlRyFGE4Dex3xyqgcAxatQbTF9o9EOqAX48ZAr24J3pBfFhPBbMP2nXl6GJ8wf8
         5OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758518; x=1718363318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nK7eNQ+hoX2l5wdTyQQ8AV5LulVt/l/ya99NvQfTdM=;
        b=PGvqdQy7UKU4DE21HwkJzmavb6pywl3D4MA15dW1TZIOrWTqJ5RB/r6VfHCJt7v6aH
         NZ1XygLkDdSN3l49WTSbc7suoLrAyJsPePaoq+BMXMQPmJEHBiNxtAfvn8Z/LAI26wbo
         ggLpZXaKN1eKfYYZ8v9GvKhJyuf9Jr3S4n+rT0Pkh7HWRHOM/XNilGfD9TLNLTH9mgW2
         8rbOR+GVoS8Tkr65sFCW/RQM5WctWxccxICaNPpMLA5l8zuploHn2r02ccWM/JbLLpwN
         GUIAknbunekiNnUsLyIBZqOTBgnwIdYoc9w+/+7OpGgj7GvAZD7qvsX9UHK+ZCTfZ/6D
         Agpw==
X-Forwarded-Encrypted: i=1; AJvYcCU1epXJYmxvWLunp4XD166OTB5bK6Ky1NrWKNrQFtuYO74+n4nGQdZw/urLYBLwm2zCtskaDhGjO+M87NUG2jyY5RvqlxKg2AILwuk2
X-Gm-Message-State: AOJu0YwJj/mA986Pim8SOZI9Pre1SKbkAFURGVGnh0GtpmwmXGKSgn1i
	sy8Ez8Qctjmr/3fcOnr5OdMMK4injuNw9drEfwb6PPwOMXdfFjETQj6Vqd07wDEMkN9SwqO15cz
	jZTQZgHnDlsNmmk94ikmIqAQC5lH96Pitrn2N
X-Google-Smtp-Source: AGHT+IEySEbc8YI+5RaCD9sW2IuIsZd7+PNu+mqp7niXSuiZHWd3aAdVtgXnRo/4POEAdDLpUYXf53dYxlwhawtJvRg=
X-Received: by 2002:a5d:59a3:0:b0:355:692:f663 with SMTP id
 ffacd0b85a97d-35efedc9eb5mr2103498f8f.50.1717758517672; Fri, 07 Jun 2024
 04:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606193318.GK8774@noisy.programming.kicks-ass.net>
 <20240607094329.3878781-1-aliceryhl@google.com> <20240607105232.GP8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240607105232.GP8774@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 7 Jun 2024 13:08:25 +0200
Message-ID: <CAH5fLgiF1bq52sTHKQRvqzVv5VP2w1WMeDZPHZ7qnxZ59zKNjQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add static_call support
To: Peter Zijlstra <peterz@infradead.org>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, ardb@kernel.org, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, jbaron@akamai.com, jpoimboe@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org, rostedt@goodmis.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 12:52=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jun 07, 2024 at 09:43:29AM +0000, Alice Ryhl wrote:
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Thu, Jun 06, 2024 at 09:09:00PM +0200, Miguel Ojeda wrote:
> > > > On Thu, Jun 6, 2024 at 7:19=E2=80=AFPM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > > >
> > > > > This is absolutely unreadable gibberish -- how am I supposed to k=
eep
> > > > > this in sync with the rest of the static_call infrastructure?
> > > >
> > > > Yeah, they are macros, which look different from "normal" Rust code=
.
> > >
> > > Macros like CPP ?
> >
> > Yes, this patch series uses declarative macros, which are the closest
> > that Rust has to the C preprocessor. They are powerful, but just like
> > CPP, they can become pretty complicated and hard to read if you are
> > doing something non-trivial.
> >
> > The macro_rules! block is how you define a new declarative macro.
>
> I'm sorry, but 30+ years of reading ! as NOT (or factorial) isn't going
> to go away. So I'm reading your macros do NOT rule.

So you already understand ! in two ways, but you don't want to add a
third? That seems to violate the Zero One Infinity rule. :)

https://en.wikipedia.org/wiki/Zero_one_infinity_rule

> > The ($name:ident($($args:expr),* $(,)?)) part defines the arguments to
> > the declarative macro. This syntax means:
> >
> > 1. The input starts with any identifier, which we call $name.
> > 2. Then there must be a ( token.
>
> The above exaple fails, because the next token is :ident, whatever the
> heck that might be. Also, extra points for line-noise due to lack of
> whitespace.

The :ident part means that $name should be parsed as an identifier.
Similarly, the :expr part means that $args should be parsed as an
expression. It doesn't mean that the input should literally contain
":ident".

> > So for example, you might invoke the macro like this:
> >
> > static_call!(tp_func_my_tracepoint(__data, &mut my_task_struct));
>
> static_call NOT (blah dog blah);
>
> > Inside the macro, you will see things such as:
> > $crate::macros::paste! { $crate::bindings:: [<__SCK__ $name >]; }
> >
> > The Rust syntax for invoking a macro has an exclamation mark after the
>
> Like I said before, the creator of Rust must've been an esoteric
> language freak and must've wanted to make this unreadable on purpose :/
>
> Also, why the white space beteen the :: scope operator and the [< thing?
> that's just weird. I would then expect the output to be:
>
>   ...::bindings:: __SCK__my_static_key

Sorry, you are right. There is a space in the output.

> > name, so you know that $crate::macros::paste is a macro. The `paste`
> > macro just emits its input unchanged, except that any identifiers
> > between [< and >] are concatenated into a single identifier. So if $nam=
e
> > is my_static_key, then the above invocation of paste! emits:
> >
> >       $crate::bindings::__SCK__my_static_key;
>
> But it doesn't, so it isn't unmodified, it seems to strip whitespace.

Thanks for the correction. The actual output is:

$crate::bindings:: __SCK__my_static_key;

However, although whitespace is generally not used here, the syntax allows =
it.

> > The $crate::bindings module is where the output of bindgen goes, so thi=
s
> > should correspond to the C symbol called __SCK__my_static_key.
> >
> > > > Is there something we could do to help here? I think Alice and othe=
rs
> > > > would be happy to explain how it works and/or help maintain it in t=
he
> > > > future if you prefer.
> > >
> > > Write a new language that looks more like C -- pretty please ? :-)
> > >
> > > Mostly I would just really like you to just use arm/jump_label.h,
> > > they're inline functions and should be doable with IR, no weirdo CPP
> > > involved in this case.
> >
> > I assume that you're referring to static_key_false here? I don't think
> > that function can be exposed using IR because it passes the function
> > argument called key as an "i" argument to an inline assembly block. Any
> > attempt to compile static_key_false without knowing the value of key at
> > compile time will surely fail to compile with the
> >
> >       invalid operand for inline asm constraint 'i'
> >
> > error.
>
> You can have clang read the header files and compile them into
> Intermediate-Representation, and have it splice the lot into the Rust
> crap's IR and voila, compile time.
>
> You just need to extend the rust thing to be able to consume C header
> files.

I wish! There are people, including me, who want this. See e.g. this
very recent document:
https://rust-lang.github.io/rust-project-goals/2024h2/Seamless-C-Support.ht=
ml

But there are also people who dislike the idea, so it does not have
unanimous support yet, unfortunately.

Ultimately, I have to work with what exists today.

Alice

