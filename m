Return-Path: <linux-kernel+bounces-526518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD8A3FFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8388619C792C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4B2528E4;
	Fri, 21 Feb 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hNEC1CAY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3B1CD1E1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166263; cv=none; b=hC+SrY/UdvrSg6jiXmK8ygokNXJVcYxDoiqJI7ZAGgmkChELZbuT1VXAtBO6p+5WQ/gbQicdDXznboJVWLdzFyEgyZfUslPJ1GASv6pEo0IPrDEyRwziTTtlYnzwYoTAriWt0q5mNgNz4lBcpYfNDmprXhC7DZ/kPyw//j1mIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166263; c=relaxed/simple;
	bh=+RfEgo2NPzN8K1yBWcrB0J1ymaB8NkbaJD+o1y0UEQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnB8XqtbZ0RrJgJiK2/Q6+rHai0HQqq5dv/5wsbZsMdf21GpMMU3jm2n5NImIDU4bJRcB4SyocwhYu0piO6kwtto1oGn1fs2L/BzCdpbH3FFX0G8iUEoagLoN8TvXf0d2uTr4r7Ufi/pz3HcQhNAGwP5f9QAEy2uPBjoQrenADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hNEC1CAY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so3462275a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740166259; x=1740771059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CaSzc1+NZ6cbiR+JimbofLj0D3GrK6Qy70Ol4U5T84=;
        b=hNEC1CAYt8O0hSAHfSiPU3fR47UXlDhUTxp7NivBk3qRxTq7ucyYwAkng6fAjxF5Ww
         ysX2I9hEDWKurTwFx5/uBg5aYqEkvNz/tGh4JBrZWG6XsYmdaCbdd3wyo34Qyzr2hJBe
         HxDQT0gQzZKI8a9f3myOpdJvc+Jzdytk5bMMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166259; x=1740771059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CaSzc1+NZ6cbiR+JimbofLj0D3GrK6Qy70Ol4U5T84=;
        b=AR2fGtBq4Kmr2kleoc50Or1RtrXM1LwJgtxreDF64/VKSRMiQYcmCpqKmn0zw/Z0RL
         +vWASXSCj4j4YOsP/6UfrD0UXJZbpefqVo3VyTb25JiGVhTZL/sp9nZBnqBviUElocsS
         sp+kRvOzLuqSMaRpVudZMSV47T8LbHuvil7lTIESfWxeLIE/xiAyruBjPwpv7axzWU1+
         MIk1VyQsr1+SPqYe88iMigvvdH8KfPigLhRfOXP2qxBPYPnlpbVV9QdiRFbpY0Rd1pkq
         td02iYk75FmgxnZQcn+0jGFZ4jykTfZnaZIJLE/s/gFJ84eUwLBzVRZcszcwFa+f5ZiT
         t0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjzoXfOwGl0il7ETFsRhs2hYaP15nkL05B2j24mUg1oShFgtRB9eryuPk0z3wFSZlrDh3fNmPbMr06xyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DbfRI/XiANQA1CODNqdXsvTqLnO1xwnPl5AYdMjv8uaddzkf
	S95z+J9xFJquuSMBir7RVcCiNqOHESPzScd1f8LVOWHF5fp9Yb8Zod4wrrNm35CcuZBPxF8sysE
	cyzo=
X-Gm-Gg: ASbGnct0KdM4x8kErNdFmw1gZSZeMYYU5RFDJ4zQrFVwfPlVc3OvxSP8dHUcGP4T0Pc
	LI0mdsBXvc4kuDLjWMcYFRtrfAOioVcPH23yBCCF0HaiCZrZ/6Ro8oXBOg26a6iU5xEVF/L1lWO
	172WOM52YV9RdRGJCmI3Reqyqh2bkzY//izQpdjwjwEB09/S0vpKlEHckzNNPF01dY5t7AJM7ky
	7ZNc/BBYhfK97dli7FeA/fNeoEGNGf0rrY8yP4DMsPe033cPwSG3QjYA+HlMjnuWXU6iCndvvWJ
	kQXL1hx4pX526PiqtZCXULL/L8TJ6DEBnieCpfWMhG0YXkV8ujsApCVV/ksOGAxN1MMOFkdCVwL
	h
X-Google-Smtp-Source: AGHT+IFN7TrSmhkOv2O3I5OtsiRtf7thj5YS4YPTomhRwag81fGJ5Jsdnoa4aKx7ZVVVWeyGzvzhgA==
X-Received: by 2002:a05:6402:2808:b0:5e0:2d53:b2a with SMTP id 4fb4d7f45d1cf-5e0b70c0d82mr10084855a12.3.1740166259253;
        Fri, 21 Feb 2025 11:30:59 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbeb38e05dsm417110666b.90.2025.02.21.11.30.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:30:58 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbae92be71so285940266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:30:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHfVelzJUThMC8WEcwSz6YMSX5wSKVYO2EoYDBCNzExYbdExSoMhj65dO+Y0ZJ3ccb3N3evYZhiR50kNc=@vger.kernel.org
X-Received: by 2002:a05:6402:530d:b0:5dc:5ada:e0c7 with SMTP id
 4fb4d7f45d1cf-5e0b7253852mr10092967a12.26.1740166258146; Fri, 21 Feb 2025
 11:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh> <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <2025022042-jot-favored-e755@gregkh> <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain> <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
 <20250221124304.5dec31b2@gandalf.local.home> <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
 <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
In-Reply-To: <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Feb 2025 11:30:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
X-Gm-Features: AWEUYZk2ROF9Gz3ijYo2QrCtR7asAMoIhd-gvs3NVhzWEfN_JKozPalppZ_7PrY
Message-ID: <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Martin Uecker <uecker@tugraz.at>
Cc: Steven Rostedt <rostedt@goodmis.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 10:31, Martin Uecker <uecker@tugraz.at> wrote:
>
> The issue with __attribute__ is that it is always tied to a specific
> syntactic construct.  Possible it could be changed, but then I do
> not see a major difference to _Pragma, or?

Oh, _Pragma() is certainly more usable from a pre-processor
standpoint, but it's still garbage exactly because it doesn't nest,
and has no sane scoping rules, and is basically compiler-specific.

Don't use it.

It's not any better than __attribute__(()), though. The scoping rules
for _pragma() are basically completely random, and depends on what you
do. So it might be file-scope, for example (some pragmas are for
things like "this is a system header file, don't warn about certain
things for this"), or it might be random "manual scope" like "pragma
pack()/unpack()".

It's still complete garbage.

> > This is non-negotiable. Anybody who thinks that a compiler is valid
> > warning about
> >
> >          if (x < 0 || x >= 10) {
> >
> > just because 'x' may in some cases be an unsigned entity is not worth
> > even discussing with.
>
> Do you think the warning is useless in macros, or in general?

Oh, I want to make it clear: it's not ":useless". It's MUCH MUCH
WORSE. It's actively wrong, it's dangerous, and it makes people write
crap code.

And yes, it's wrong in general. The problems with "x < 0" warning for
an unsigned 'x' are deep and fundamental, and macros that take various
types is only one (perhaps more obvious) example of how brokent that
garbage is.

The whole fundamental issue is that the signedness of 'x' MAY NOT BE
OBVIOUS, and that the safe and human-legible way to write robust code
is to check both limits.

Why would the signedness of an expression not be obvious outside of macros?

There's tons of reasons. The trivial one is "the function is large,
and the variable was declared fifty lines earlier, and you don't see
the declaration in all the places that use it".

Remember: source code is for HUMANS. If we weren't human, we'd write
machine code directly. Humans don't have infinite context. When you
write trivial examples, the type may be trivially obvious, but REAL
LIFE IS NOT TRIVIAL.

And honestly, even if the variable type declaration is RIGHT THERE,
signedness may be very non-obvious indeed. Signedness can depend on

 (a) architecture (example: 'char')

 (b) typedef's (example: too many to even mention)

 (c) undefined language behavior (example: bitfields)

 (d) various other random details (example: enum types)

Dammit, I'm done with this discussion. We are not enabling that
shit-for-brains warning. If you are a compiler person and think the
warning is valid, you should take up some other work. Maybe you can
become a farmer or something useful, instead of spreading your manure
in technology.

And if you think warning about an extra "x < 0" check is about
"security", you are just a joke.

              Linus

