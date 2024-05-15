Return-Path: <linux-kernel+bounces-180193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB2F8C6B53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9A01C23431
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35A5C61C;
	Wed, 15 May 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSIZ8j2a"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF184C3CD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793155; cv=none; b=gXYx/7cYn2OIlgO40dN3qxqGlPJCm6vGFq/FTmAONozK7y2LqG30o5uCQm9rv21nNEymmlvBtzM0SsBfd4lNlN29qg3G+pCpD1eQYRV+klbGFZY6MlcETPwqOefP4CLZd1QY5MO8cW1hh0VM4qK4xtbtcOz3ofhK6Gu4FYdCMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793155; c=relaxed/simple;
	bh=sFdFO/3PseRV0I24tfvAl/Tu3SeNdZ+dYLb3bjXAJu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWsRfcOTdRbYBOt/Wpm2rd1qyrE2qlgshoE8CZ+Cw4q4hnM8aS+LkbLDw1KxjoshcXwhjzo6tpf07MugOVsGIug1lUOf7f21Z2NMm0WnDWwXXAX9JmzWSNKuWr0nTbKAmH1STV/gbH01Wu5GnrF2jcqxCeKonOYhPuvPbBIofjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSIZ8j2a; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23f9d07829bso3425451fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715793152; x=1716397952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFdFO/3PseRV0I24tfvAl/Tu3SeNdZ+dYLb3bjXAJu8=;
        b=QSIZ8j2aBzKVx6dFzUgfgxy4FxbPy1RzZSOEF/YtKW5zI2kRPd9V9sXohfMKvvfGnh
         LIAUgBErOhh9hf3cRKmJ1+CU/v6SuBPWFzseVylOOzQSCUiwEIZ2YAmjbqcr5EGHovNV
         PglXLUOMIKQXEVZb7WgTrELqyRLZEwPJuH7TBACQb9UMCBcvYp3M9yWB3/vUduOwqVek
         SMzSFUplHOgX7RvyTB5JlDn9Qt5/1/nElbYNG9wl5GEx/T1Q7xVU37CBEb/+wbPONmV0
         g8VLgj3E5xsZuWd+DtjDvl4TEy0pmuMro5lqnnOuOnr+ymxbu1bOuA8lXIz7DYTqj0QX
         UdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793152; x=1716397952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFdFO/3PseRV0I24tfvAl/Tu3SeNdZ+dYLb3bjXAJu8=;
        b=buvEF7EUNWEc3kHl4oz1LmYEM1DkagOFPt1x3eACDMvsR5AEu/tYd85fRPFOZLP+/y
         O8ENQmWmUUgoB6ZLtjZ4NiQF0DGDcIcvnN3Tw0XN3pUCD9yzKNi0yc1Fxaek1qS+KFcD
         RDcpuIs3GK+Ehvj+FQPIKfODd8rwuaHNk4RUnDftgVlQofEcvL/LWn2ak9M76crsFqU7
         kUZ4nq0xQO3Yqnh5e7i0RzL8CxLGTS1vPULjXRmca4IEO0oseRuRFiJ9iLIHD/QSks/W
         JLIy2GjWfNgzEWkyEszZAguZaaCeH+JT3cBiTCRS8uaA85hVsu8Elv4zlD5XPIDmhKbH
         cMTA==
X-Forwarded-Encrypted: i=1; AJvYcCVkTzjVxcAHDgAdX/UhkqpPCV3RuoWANUEaqGE79UPvEkkEQUPgnVAM+XCT1Ft/vrbqLndj4ttyRXV6jBtt2iu9CcjXN58dKWoHVetd
X-Gm-Message-State: AOJu0Yy6lM192svla7jBlRA8zZYDZUWI/htqqVyRlLbq9P+Cxy/gTX81
	1H318GeHcZGVhRjPiz0zc6Jc1pAmEDcFz0rVOgbLsGvDWzgEk9U4wSu6sbk5/vglkawOlCqyjlf
	Bb7f7ja7hhS9+zG0w5dbch9Lg7L3gCuHWin4p
X-Google-Smtp-Source: AGHT+IHdPnCg97tJxWZG1Gb/DpWshKQCgosn26p/oXEI08Q9kC9bnAhNtdBzk1KnL1lvOIiK1jkJOT92D0YO6qHuMVs=
X-Received: by 2002:a05:6870:1690:b0:23c:ee0a:260f with SMTP id
 586e51a60fabf-24172a23552mr18594820fac.3.1715793152544; Wed, 15 May 2024
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240515073636.GY40213@noisy.programming.kicks-ass.net>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 15 May 2024 10:12:20 -0700
Message-ID: <CAFhGd8qKObvqbLJWvkG+Wfuy0gpWiTsSmFrBO-NzC-akB6bhzA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, May 15, 2024 at 12:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, May 08, 2024 at 04:47:25PM -0700, Linus Torvalds wrote:
> > For example, the most common case of overflow we've ever had has very
> > much been array indexing. Now, sometimes that has actually been actual
> > undefined behavior, because it's been overflow in signed variables,
> > and those are "easy" to find in the sense that you just say "no, can't
> > do that". UBSAN finds them, and that's good.
>
> We build with -fno-strict-overflow, which implies -fwrapv, which removes
> the UB from signed overflow by mandating 2s complement.

FWIW,

Clang-19 allows -fwrapv and -fsanitize=3Dsigned-integer-overflow to work
together [1]

And the sanitizer was re-introduced with Commit 557f8c582a9ba8ab
("ubsan: Reintroduce signed overflow sanitizer").

>
> With the exception of an UBSAN bug prior to GCC-8, UBSAN will not, and
> should not, warn about signed overflow when using either of these flags.

[1]: https://clang.llvm.org/docs/ReleaseNotes.html#sanitizers

Thanks
Justin

