Return-Path: <linux-kernel+bounces-314734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92EF96B7CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546B01F21A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2EB1CF5C9;
	Wed,  4 Sep 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqN68MbP"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BF1CF5D3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444342; cv=none; b=PXbBRmE9enGVi3iI1E75bVU49DdNYTvaGppEkg8xs7xCTYQsGLGk06+A9YMQyOfJjHU0SqOm7eWXcPuSQvoWAKhP2VFNipL/JBgfs7l0trDTKrA02a0EUicH9E0H5uTCB7z/2ydnuExEdwYBCMTF8+DqBPp94slXo+8iNBbulvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444342; c=relaxed/simple;
	bh=qKxfA0ClsNmcJkbtBwmSmCYZJ9vmXcRSSui0jEv6Uys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVRoV9IYmaO28a3nLCRepapiB52IR2Kk3qwOU1XVQWEcQi4KZGwOZTKM5Mj0KEAqyQnwHd6XfLLtnnxMwEzxiSofC8ZG229YDtYo7LkwoaRV76j+WYFthVHMOcN8frQEVDhEbncHnQB8/YhFnntW/fmNESmkQBL247TQUhCRQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eqN68MbP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70f59acf6c7so313692a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725444339; x=1726049139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIEqtb0/9F1loSbNbXhveL3mObT0bYvJU/ZvAslsQR0=;
        b=eqN68MbPuFRTgQv+DxwvbVZQyb3WrTI4QYK1prffBAMktfqLScFHNhq0/9YAEWCXOv
         2MBhbl40KV4avMc9NnPGY4WvvqKC8b57shDGJw1Ui0vltMHmjREOdczwrh5HpHL+v29D
         EixZj8oE1xNf+aQYS1AXWLGRtaXw4Led3alwFINuo+oSgPmbe7/dRo2reaGfK3089U7+
         Z8TSuS1Wwfx+hKQ7FU5X2YMWYtQPdaMrJWO4+Y6G0ZqXVBRlaByudsU/vTc8BZQ3kqKE
         V6fX3k+wBxo5bpabZRm86srKG5FAD6iYGLAfzj7QUDzjLAvc4yFk8IQ39v4kpw1ZVjnZ
         96rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725444339; x=1726049139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIEqtb0/9F1loSbNbXhveL3mObT0bYvJU/ZvAslsQR0=;
        b=RKCFPIPT4B/N7q2YmpMMijweVIBmKpRaRR0PR9KdVG4ygKDAsK6SVMBQtMxRcSdwSZ
         uyXd/k0CI6zCGbTP7D7vzZ+SEsXjXZJRLDrLaay6aaTtIKZvQ3cz/e0KqVdCBrNfB0eh
         gEAiLNTv1yrAddGMEIR/jkursVwtBHYIppJz88tAmMstc682KID14xcypfKGXAUwsC5P
         U5Eor+fcR9VzTwVEtHkrnDHHd+eaZJGxdMq7BB8B0d29tj3R6ek/x3eSniswrZdGlYGQ
         fkeG9e2fVAKpKjgkyLF4Pk2ZbDGG1XRqCDkwXG0w/p45GQHYctPazthYQgU7S1dQMKUg
         270Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4Ta+rqbdOsQ+hPe/JIukDiZDfcYDcqRxBXBvrISCEx7cfTEhft4IBmVi3SDUUUXapYVl6gLqx0aUHURI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzex4puD9pfANA1+lCKUjGVxVjvvn1DNKSmStvNNA1olOm1ZOJZ
	xG3sJ3PgBgSDpnmDHt1fmtermMPPKZluPxTQ2clICJ+drdZEI6fB4IJB7du5CJ/HXzOOjn9ZpP1
	hhzkpoQDqinsSEy2X+JdpK07UBkKdVFmYjV0YeadP6cpjYpGB
X-Google-Smtp-Source: AGHT+IHKr3MA3hwPxyiGJmcFol57BYdcbd6OW2LBeXJN0l/coREJFmMP/eCrcFKSlEyU226769uZzSp2VNuZj862uw4=
X-Received: by 2002:a05:6830:620f:b0:703:77c0:cedb with SMTP id
 46e09a7af769-70f684a03cbmr10137918a34.1.1725444339557; Wed, 04 Sep 2024
 03:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYN=9JBw6kq4E9aA=Pr1rFy-6tY-j-XOthQVYVw6ptmj11=HA@mail.gmail.com>
 <f3fe6be4-723e-45b8-baa6-5c285cc5c150@redhat.com>
In-Reply-To: <f3fe6be4-723e-45b8-baa6-5c285cc5c150@redhat.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 4 Sep 2024 12:05:28 +0200
Message-ID: <CADYN=9+xONPg=UrApM9xsKs2Um3VDMCi5X0684k0idJv-th82w@mail.gmail.com>
Subject: Re: Potential Regression in futex Performance from v6.9 to v6.10-rc1
 and v6.11-rc4
To: David Hildenbrand <david@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, dvhart@infradead.org, dave@stgolabs.net, 
	andrealmeid@igalia.com, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sept 2024 at 14:37, David Hildenbrand <david@redhat.com> wrote:
>
> On 03.09.24 14:21, Anders Roxell wrote:
> > Hi,
> >
> > I've noticed that the futex01-thread-* tests in will-it-scale-sys-threa=
ds
> > are running about 2% slower on v6.10-rc1 compared to v6.9, and this
> > slowdown continues with v6.11-rc4. I am focused on identifying any
> > performance regressions greater than 2% that occur in automated
> > testing on arm64 HW.
> >
> > Using git bisect, I traced the issue to commit
> > f002882ca369 ("mm: merge folio_is_secretmem() and
> > folio_fast_pin_allowed() into gup_fast_folio_allowed()").
>
> Thanks for analyzing the (slight) regression!
>
> >
> > My tests were performed on m7g.large and m7g.metal instances:
> >
> > * The slowdown is consistent regardless of the number of threads;
> >     futex1-threads-128 performs similarly to futex1-threads-2, indicati=
ng
> >     there is no scalability issue, just a minor performance overhead.
> > * The test doesn=E2=80=99t involve actual futex operations, just dummy =
wake/wait
> >     on a variable that isn=E2=80=99t accessed by other threads, so the =
results might
> >     not be very significant.
> >
> > Given that this seems to be a minor increase in code path length rather
> > than a scalability issue, would this be considered a genuine regression=
?
>
> Likely not, I've seen these kinds of regressions (for example in my fork
> micro-benchmarks) simply because the compiler slightly changes the code
> layout, or suddenly decides to not inline a functions.
>
> Still it is rather unexpected, so let's find out what's happening.
>
> My first intuition would have been that the compiler now decides to not
> inline gup_fast_folio_allowed() anymore, adding a function call.
>
> LLVM seems to inline it for me. GCC not.
>
> Would this return the original behavior for you?

David thank you for quick patch for me to try.

This patch helped the original regression on v6.10-rc1, but on current main=
line
v6.11-rc6 the patch does nothing and the performance is as expeced.


Cheers,
Anders

>
> diff --git a/mm/gup.c b/mm/gup.c
> index 69c483e2cc32d..6642f09c95881 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2726,7 +2726,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>    * in the fast path, so instead we whitelist known good cases and if in=
 doubt,
>    * fall back to the slow path.
>    */
> -static bool gup_fast_folio_allowed(struct folio *folio, unsigned int fla=
gs)
> +static __always_inline bool gup_fast_folio_allowed(struct folio *folio,
> +               unsigned int flags)
>   {
>          bool reject_file_backed =3D false;
>          struct address_space *mapping;
>
>
> --
> Cheers,
>
> David / dhildenb
>

