Return-Path: <linux-kernel+bounces-182666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DC68C8E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC27828619B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26814198A;
	Fri, 17 May 2024 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfIx+HD5"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA01411D1
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983476; cv=none; b=YVEAgKKhln4lxPEMB1576ItYdfz+Ae+dc/lGOpeuLZAMDPmJ1oa1Eqh1VmSn5OQO/E/LKG6wgNaMzJL2W1Jbd9h9Nm1wwja5w8Rnly3nDSkhPTzEigmfZ4wPs3+3xpy4Lx1Q6Os6QTZn2+5ExgHHcUGpu0qVE3+titBYimSLQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983476; c=relaxed/simple;
	bh=BdhITRnNU+REXc7LnQZeK8vjGpGDGI/srKqx0YLNYAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFQTd4CkyFzoKBK35h8pSdKhLm4asgAFGI923ZyVtvwroQvKypcPEXmSX53tFNaPQWPaJy0iugOfizwNrUv6QSv4XY3qL2DL34gX9gX2xttW42dVm3aeRWibVz1imk6u6b5+uKZirpqeC1Js6kS+CHsAtcGcqQoBpY56WVQo/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfIx+HD5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso1018a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715983473; x=1716588273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPcNSrh3uuZ5e6UcUtMkeuMK0XXETcsLkcdKBYaf5FE=;
        b=FfIx+HD5VxCqbtJM9KXjjvO9XI5GzPZfAlDQf8RnsSIzu4Gb0lS1x2IV0/4+gdpbUW
         4AsagMwj2YWrrTEGahhJlKxihFXGewmN5Qk7DL/eHo+y+QYRFR8hA0JdyCrAsClOcmzZ
         RGxZZOwWZlJVb5r+C9QQu93QNrh6DmXY/6RbOIN16oERqLOm+jf/HUMkWv9hKFE0nDuR
         IZn5nYhBIm/edSol7rdhqz6LlHYXbNpBK5uNnUMs0Ip/R26hGFdyte59muCdzW2dQhCV
         vV4RyJ1bE2efqPJ8SgZAClF6llkEY3LYgxYAWjYbTV9wH/S+1ZUyZk+25lGEaYQtVGZ0
         FM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715983473; x=1716588273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPcNSrh3uuZ5e6UcUtMkeuMK0XXETcsLkcdKBYaf5FE=;
        b=l/JvNbP9YWMaK+GpS2saGvd0i4apT+sxA1cdSsKj9Xa4vt8s7dp80pyCBtkIGIIY4z
         /O7xF7XCRT/7KZsEtY+uqAd48WjhDX2wvp2gCzmEQlkpXo4atTQ/bwT6vvO/b21AAkVY
         LQqOfevSpZxHDTIGHMT8HJ6oL7eksUIvvTfzL/zyF6qjH1FOG2HrlMHOFyy3fLXceQ1T
         yC9O7tGjYAZXml602uouC8/VHa/Ad2/lJgOBadMSf0246bErUSg6wu+4DdjCEftoyvsw
         ApXb9O9di6OZNQ/CKoD8MtBvp2AAEpEgD4rCisrvv/yuDZOhD+IjAEog7Sudy7sUDMfe
         4ymA==
X-Forwarded-Encrypted: i=1; AJvYcCUf0M3PipbCOR9I1it7OdBZSehxxRJ/BEKcSWIPLvS5ix8LdsL9ZntnjTrlYinM8yAT/ooO9IXI6s+3zUMgFdyUBBioMNvLLzg5b4/l
X-Gm-Message-State: AOJu0YwVR0MwWFB3s9aDnbXk9JiANuAGckYEMS+wM+Y4WvRuvHXt0g03
	taJRoXkWpd4SN/VfxQNvYnuyPRyRB/cN31MwM9wh2uDnFLs2It8ikXgaqWtJ8+lOwrmkMry2yWm
	b11pEP0upiVjYdDE2IWPBLOEHNijzCKP28TgD
X-Google-Smtp-Source: AGHT+IHDGePJQkBnkoeUr2NjZz8xln85qYzCfOTxtm5xhcDt6tF1xHyaN0XWlD6rZ7LpWmCymVL1628hdIUkS3q51ro=
X-Received: by 2002:a05:6402:44b:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-5752c7d36e8mr24826a12.7.1715983473042; Fri, 17 May 2024
 15:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net> <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
 <20240516140951.GK22557@noisy.programming.kicks-ass.net> <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>
In-Reply-To: <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Fri, 17 May 2024 15:04:21 -0700
Message-ID: <CAFP8O3Jq9kxx8xp4hK42+FwL3KnibDqpke5S7zT40kwmaEfXcA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:49=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
> Hi,
>
> On Thu, May 16, 2024 at 7:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, May 16, 2024 at 06:30:32AM -0700, Kees Cook wrote:
> > >
> > > I am a broken record. :) This is _not_ about undefined behavior.
> >
> > And yet you introduced CONFIG_UBSAN_SIGNED_WRAP... *UB*san, get it?
>
> We should think of UBSAN as an "Unexpected Behavior" Sanitizer. Clang
> has evolved to provide instrumentation for things that are not
> *technically* undefined behavior.
>
> Go to [1] and grep for some phrases like "not undefined behavior" and
> see that we have quite a few sanitizers that aren't *technically*
> handling undefined behavior.
>
> >
> > > This is about finding a way to make the intent of C authors
> > > unambiguous. That overflow wraps is well defined. It is not always
> > > _desired_. C has no way to distinguish between the two cases.
> >
> > The current semantics are (and have been for years, decades at this
> > point) that everything wraps nicely and code has been assuming this. Yo=
u
> > cannot just change this.
>
> Why not :>)
>
> Lots and lots of exploits are caused by unintentional arithmetic overflow=
 [2].
>
> >
> > So what you do is do a proper language extension and add a type
> > qualifier that makes overflows trap and annotate all them cases where
> > people do not expect overflows (so that we can put the
> > __builtin_*_overflow() things where the sun don't shine).
>
> It is incredibly important that the exact opposite approach is taken;
> we need to be annotating (or adding type qualifiers to) the _expected_
> overflow cases. The omniscience required to go and properly annotate
> all the spots that will cause problems would suggest that we should
> just fix the bug outright. If only it was that easy.
>
> I don't think we're capable of identifying every single problematic
> overflow/wraparound case in the kernel, this is pretty obvious
> considering we've had decades to do so. Instead, it seems much more
> feasible that we annotate (very, very minimally so as not to disrupt
> code readability and style) the spots where we _know_ overflow should
> happen.
>
> [1]: https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html#ubsan-ch=
ecks
> [2]: https://cwe.mitre.org/data/definitions/190.html
>
> Thanks
> Justin

FWIW I have made -fsanitize=3Dundefined -fwrapv not imply
-fsanitize=3Dsigned-integer-overflow in
https://github.com/llvm/llvm-project/pull/85501 .
The change is not included in the LLVM 18.1.* releases.
This might encourage projects using both -fwrapv and
-fsanitize=3Dundefined to re-evaluate whether -fwrapv aligns with their
needs.

The description of #85501 contains more information about my
understanding of kernel security folks' mind:

> Linux kernel uses -fwrapv to change signed integer overflows from undefin=
ed behaviors to defined behaviors. However, the security folks still want -=
fsanitize=3Dsigned-integer-overflow diagnostics. Their intention can be exp=
ressed with -fwrapv -fsanitize=3Dsigned-integer-overflow (#80089). This mod=
e by default reports recoverable errors while still making signed integer o=
verflows defined (most UBSan checks are recoverable by default: you get err=
ors in stderr, but the  program is not halted).


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

