Return-Path: <linux-kernel+bounces-200903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E038FB642
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E260928831F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929913CFAB;
	Tue,  4 Jun 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxPHDisb"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159312BF24
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512814; cv=none; b=EcpTboFGIa+/ny9ZCjCZDuCX304qJPr8mAxioX+Xby5ohNwJqfYBc1Hkwt9ZUjloyeVr0QIk62Zpzcyq2J3B1pLHDTGHZxLJIZyHW+Eq3w+LlfqSSAJXScHHBVZFVDuSAaO/AMHjG9JdRoDjKzfzWgq+UrUNWhG7ZA03kCpT0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512814; c=relaxed/simple;
	bh=L7H28f3+IN84GdKJSezANEn7gMV42dlcyCr9ddGa0Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoXZQX8x/toSpYmHhG8IdvQFaV+OPwcORti3tE1YmSTMrvzxz48WE2VqpUTdoK0+0JTLRq/6fPrISRIaGEbnXEE+sIoClW/t1fcgOhhskp32c2kSs4VMn2mf9H7UDeilrvYXIijHiqVjs8CzK1oXRJ8tEAxmQ5AXfWH01Q5nn14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxPHDisb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35dcd34a69bso4228097f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717512810; x=1718117610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7H28f3+IN84GdKJSezANEn7gMV42dlcyCr9ddGa0Sw=;
        b=VxPHDisbIhn3HvjbKqvuO+Xeh214qkrmOeVC3E4YcWozkTyRZAvNoprzShtCNKy3OZ
         kKFNlUEBmlVovH7YBjbhOB3WNpXOVZCphfr8jnLKZ0YKa+M10Nt3azaUg8i/pRA+e6xL
         2ZZK+XSpIh3wIvlf+9XR629+VlJuk0uU1TFihkhZXJqbem/lWf9UERa3QRW+URG34Frq
         W2im0d4kVIRnl9e+JKU+Mr7IGYpoH/0Z8ePhtc/YC6jWK915cHxg1yvsbVbYKg+Ioq0i
         w1e2o2WZHrV0sva0+wS+u1pNN8BDkeJPcIPXPMzs/BnCsDq+Jldg5ZJzCt6+I6fHW/l2
         D3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512810; x=1718117610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7H28f3+IN84GdKJSezANEn7gMV42dlcyCr9ddGa0Sw=;
        b=eicC6Oz3H/khd12h9/wgsdNLKFc9Ad/23rKqRxYpCF2r3Bu8KQ6khhqfmdwKHHFXet
         Bi9MiwQruvVOpzjFO6fdFcAVjs7KnfSSSQmk/E7MQ0jHEumfJpD58+MZJzifjVxKuxU4
         lkBNhSkxImjx9n4BsUsj3ISTkzFy1N/glSj+BEhx8EZkJMwV/et1Jy5qvvAXzULJKxPX
         hDByy0uj0VIrcWcW/Ris8nYjW1p7+LMeGbt0ZpV/tLdp+jYVchZTwPmSH4ojpYMKXy+6
         D4yk12hBLGVNEBeagsa+rCwcMLNAT/JbFTMZ/eNMWWdWCOhernmV/WrMvFRN8yLczA60
         xWRA==
X-Forwarded-Encrypted: i=1; AJvYcCVQAUcs5CU2dE5TF7Kz9c0vJnQVHxxeDX9xvWtTD3t3O7gkfyXVjtLYrARDSzRjSjgom2OgniHpxvQiI+Jqyev55YQm61uWy2AK+fss
X-Gm-Message-State: AOJu0YzDP0Ge1ALt3jeuO99jgDsA1WHCSJ2fXOd49UzY7ipS11JxvfOz
	t+FVfvlwuGGI8/+HcziTDPRyok8dt8ykALPd8OHHe59Tfhm+eRSYY8hHeAo4aivN9AtwjAUaF65
	1uZjgyadyw+h7nYjpxYamqsD6LHAhpcGK1qKx
X-Google-Smtp-Source: AGHT+IEOWlKPI8YyC6/+P3wiowV9l4424Q+QWgWOvqOevjiRpFaEqUQMgrTlM58GWEO3enYhsbSotHsRcNE4cPwniNQ=
X-Received: by 2002:adf:f742:0:b0:357:3e5a:6c90 with SMTP id
 ffacd0b85a97d-35e0f36d84amr9128831f8f.57.1717512809973; Tue, 04 Jun 2024
 07:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409103120.GA22557@willie-the-truck> <20240430110925.1064685-1-aliceryhl@google.com>
 <20240604142941.GD20384@willie-the-truck>
In-Reply-To: <20240604142941.GD20384@willie-the-truck>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 4 Jun 2024 16:53:16 +0200
Message-ID: <CAH5fLgimyYmS33EPEQb6R5Lrmkzv+0GNRE7NQwhfEaJFqb4OYQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add flags for shadow call stack sanitizer
To: Will Deacon <will@kernel.org>
Cc: Jamie.Cunliffe@arm.com, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	ardb@kernel.org, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, broonie@kernel.org, catalin.marinas@arm.com, 
	gary@garyguo.net, keescook@chromium.org, kernel@valentinobst.de, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, masahiroy@kernel.org, 
	maz@kernel.org, miguel.ojeda.sandonis@gmail.com, nathan@kernel.org, 
	ndesaulniers@google.com, nicolas@fjasle.eu, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, samitolvanen@google.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:29=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Apr 30, 2024 at 11:09:25AM +0000, Alice Ryhl wrote:
> > Will Deacon <will@kernel.org> wrote:
> > > On Tue, Mar 05, 2024 at 01:14:19PM +0100, Miguel Ojeda wrote:
> > >> Otherwise partially reverting to the `target.json` approach sounds g=
ood too.
> > >>
> > >> I added the `-Zuse-sync-unwind=3Dn` to the list at
> > >> https://github.com/Rust-for-Linux/linux/issues/2. Given the default =
is
> > >> what we want, I have put it in the "Good to have" section.
> > >
> > > I think we have time to do this properly, like we did for the clang
> > > enablement a few years ago. In hindsight, avoiding hacks for the earl=
y
> > > toolchains back then was a really good idea because it meant we could
> > > rely on a solid baseline set of compiler features from the start.
> > >
> > > So, please can we fix this in rustc and just have SCS dependent on th=
at?
> >
> > Just to keep you in the loop, I've posted a PR to make rustc recognize
> > the reserve-x18 target feature, so that the -Ctarget-feature=3D+reserve=
-x18
> > flag stops emitting a warning.
> >
> > This should be sufficient for adding support for CONFIG_DYNAMIC_SCS.
> >
> > You can find it here:
> > https://github.com/rust-lang/rust/pull/124323
> >
> > As for non-dynamic SCS, I plan to tackle that after the PR is merged.
> > See the "Future possibilities" section in the linked PR for more info o=
n
> > that.
>
> Thanks for persevering with this, Alice. I read the pull request above,
> but it looks like you went with:
>
> https://github.com/rust-lang/rust/pull/124655
>
> instead, which was merged (hurrah!). Do we need anything else?

Yeah, it took a while, but I've managed to get a -Zfixed-x18 flag in.
It will be available starting with Rust 1.80, which will be released
on the 25th of July.

A few things:

1. The -Zsanitizer=3Dshadow-call-stack flag still doesn't work because
the compiler thinks that the target doesn't support it. I'll fix this
eventually, but at least CONFIG_DYNAMIC_SCS works now.

2. I haven't convinced the Rust maintainers that -Zfixed-x18 is the
way to go long term (flags starting with -Z are unstable and may
change). Some of the maintainers want to instead add a x18-available
target feature (that is, the inverse of the current reserve-x18 target
feature), that you can disable with -Ctarget-feature=3D-x18-available.

And a few questions for you:

By the time support for 1.80 goes in, we are probably supporting more
than one Rust compiler. For pre-1.80 compilers, should we fall back to
-Ctarget-feature=3D+reserve-x18 (which emits a warning, but works), or
fail compilation?

Similarly, we should probably submit a fix to the stable branches so
that SCS+Rust doesn't silently break in a hard-to-debug way. Do you
prefer a backport with -Ctarget-feature=3D+reserve-x18 or one that fails
compilation?

Alice

