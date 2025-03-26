Return-Path: <linux-kernel+bounces-577672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22DCA7201B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63F33B8B36
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2D1EA7F3;
	Wed, 26 Mar 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d260P5wQ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD01A2541
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021931; cv=none; b=f9zX3pN2CmE4nAv0N/MT/s9iv06ZYAjzl8wNR5I53E7kuGL3o+HpaNOsnRQGbdr/P69Ce2L/cg0l+mOL4014frvH5XgCvYF0XiGefl4X7FFmXDr28HltyNYpcG9eI+o4sDBP68ZC9bde8r5HvngjW6EuVGDtRJ/eLvPzhMvs4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021931; c=relaxed/simple;
	bh=bpCz5P/IGbW1PJcmJdHsh0Ct4MpaP9/+sfxMG+ksfRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6bqL7B4fxtW28Dz1Nvan7bKffbz6j3U+TzU9q5TTtcJHUyjseGMIg22CDo+aCbS9u8G2llH0L5GPCwzcgzQbVa4/1rF4myOQpTBP4sCeK7BZZgZGAHh+wO/7CQ1pwOwjY0VQ0fxyroaH0+eMhyI8Aquh6I+xhyCEAL/OjXHEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d260P5wQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so958a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743021928; x=1743626728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7ktHXesu2kfcG5Dhn1yOjglQsPkU7kg2rXgHib344o=;
        b=d260P5wQHa/fWoX2/Be/iIY26P6GR057Kcg30KMVLYimA1hO/x3R6+Hj+qQUzk9zMX
         pW0WmUCp+AbAT9E1/4urY+RdJ+Ioyt+QQmTFu89IdPvkIlkS43XmbJU1ogNI3YMmHjiO
         ClaYwxCLeRVczjyU60Yxay65rIDTgngXgFxSakI/Xz8CZTwvI0Reu4gLXwKe5bh3BhNI
         6oh6Xcm1cp8vqOxh+xPtzJ9trtgNWtS+Wx1Abm7o8MfB9QwH5KEcDG7yFfjXe010u6vw
         nCAg9ZrK4mru/A8eR7OIyTpFqw1DKhK7laJKv8RUqGqTA06aMWR50uWljALxTMKM35Sj
         bH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021928; x=1743626728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7ktHXesu2kfcG5Dhn1yOjglQsPkU7kg2rXgHib344o=;
        b=fI8Rqo+GTAptuuKmELSn8Z47s8ngf+JNgzgn/d2Z+HK13E04Uw0oS+BozA5Nji92yL
         j3GJlaFbYeiVC6lg4NmRJPL+i6tFWxjA4lQv32A8l3SE95XgMUfUnaW9Ncqbr6vjlt9a
         +ANHwzy0fOMu6cwn/U2vLxGAM6ixl+DfjXgauk/Y7FhZzqZs6vUYNHDSige5mENCvT4b
         IfLUOIGnFMZi6gU3GnR+yLNYOBfuC6RszsAemHqPgLtLdFK51+fDQDpH87KEPBbVbdCS
         dSXzRqsQGyelmE3S/OYmqDqtmw5us0syI3tpFl+nq3LGBcD1UA6DiQIZopd+4aEcFQtP
         rMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+si1YVM+OkRCZ8+ZuqdAjM/7WS+Oh5ugaA7PDysWyDjMRtxM2Fz1sJ81F1/Jl9alh+UV72MoqBNG5470=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjfoJvYbChpkiwqRHpW0VWIcSLKMwwIfyjihaPP6rVY0H4iJA
	SVaqUIrb++PH99QpdFC2gITUYZ6/skgFxNuVGn994a2tVPT9Zc9loWLeneZVRFkEgIzV0CejaQ7
	2olZ25bHIkQpKYypfaQHiO62GiUMA7Atfosia
X-Gm-Gg: ASbGncssXZUeALfVfr8J5WbdUHYyfYsV7shU0DBwckIl6Jot402AE8RZG1sCeBWetTk
	03lZwD0rGwpHHWCFYgAIWIT/QS1VhiPFIDloVzVSOhIhJMdQ5iBarvN4XtOf6mRvhPkcbVJEbPe
	IolCNAHYEgJb67DR57F/9jA746TesrqW2etg9/x9CJzzSul2GD7let/eA=
X-Google-Smtp-Source: AGHT+IHwrjgZpcRulsDKiR6zDY29alu/eb5flZ9dkCDaZWzF1ZfCyNNDZdRtJ2/5IMq9El6tbI6vFM9Cu7fmz6kLVF4=
X-Received: by 2002:aa7:db89:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5edaad0f6d7mr5611a12.4.1743021927533; Wed, 26 Mar 2025 13:45:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com> <20250326203926.GA10484@ax162>
In-Reply-To: <20250326203926.GA10484@ax162>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Mar 2025 21:44:50 +0100
X-Gm-Features: AQ5f1JrP1Q2mctLjPTyd7EAIrLTDiLFwqKWpzfLsUtx5LAsqHO0kWByN0mYn4cM
Message-ID: <CAG48ez05PsJ3-JUBUMrM=zd5aMJ_ZQT4mhavgnCbXTYvxFPOhQ@mail.gmail.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:39=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Tue, Mar 25, 2025 at 05:01:34PM +0100, Jann Horn wrote:
> > Also, since this read can be racy by design, we should technically do
> > READ_ONCE(), so add that.
> >
> > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastru=
cture")
> > Signed-off-by: Jann Horn <jannh@google.com>
> ...
> > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.=
h
> > index 8d0a6280e982..e9f2b84d2338 100644
> > --- a/include/asm-generic/rwonce.h
> > +++ b/include/asm-generic/rwonce.h
> > @@ -79,11 +79,14 @@ unsigned long __read_once_word_nocheck(const void *=
addr)
> >       (typeof(x))__read_once_word_nocheck(&(x));                      \
> >  })
> >
> > -static __no_kasan_or_inline
> > +static __no_sanitize_or_inline
> >  unsigned long read_word_at_a_time(const void *addr)
> >  {
> > +     /* open-coded instrument_read(addr, 1) */
> >       kasan_check_read(addr, 1);
> > -     return *(unsigned long *)addr;
> > +     kcsan_check_read(addr, 1);
> > +
> > +     return READ_ONCE(*(unsigned long *)addr);
>
> I bisected a boot hang that I see on arm64 with LTO enabled to this
> change as commit ece69af2ede1 ("rwonce: handle KCSAN like KASAN in
> read_word_at_a_time()") in -next. With LTO, READ_ONCE() gets upgraded to
> ldar / ldapr, which requires an aligned address to access, but
> read_word_at_a_time() can be called with an unaligned address. I
> confirmed this should be the root cause by removing the READ_ONCE()
> added above or removing the selects of DCACHE_WORD_ACCESS and
> HAVE_EFFICIENT_UNALIGNED_ACCESS in arch/arm64/Kconfig, which avoids
> the crash.

Oh, bleeeh. Thanks for figuring that out. I guess that means we should
remove that READ_ONCE() again to un-break the build. I'll send a patch
in a bit...

