Return-Path: <linux-kernel+bounces-439474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AE9EAFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75061885E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC22080FB;
	Tue, 10 Dec 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArgRMC69"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA72080F0;
	Tue, 10 Dec 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829750; cv=none; b=V5W+MVO1E+eZ1vtv84wWLcz9VpYxF0QG48P3HQZslWFXEERLioFRSBHJoMOJFkRstpB717YyTvJw7nn8xmEbQ3/+PXL/aFS8nqKkS3JTREtJ2L4U1Z5pvoFfTv3qS9jroKp5UK3imlhoRw3W7jzTDyibbMRtEB+LQ3oC4eoQ2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829750; c=relaxed/simple;
	bh=V+ILprZMKU3hTxlx44PlWoIeIjwa2pZmntXV2SS84oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyzRmWLFqa76L2mojfTySmRxVVsu7dKTvYWWzfz6KKdsuX3OgC+jbDZ9K1IXzKdMqagyiz5qrPNnAVG9Eusn9tjbdbxpZ8Fc+afH1u7GmV7vd0QEwySV/4XGbrabvx3O4U4Wfx1Bo7tvXz1cQqCeGRdNpleg0MUESA1BpHDCqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArgRMC69; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee8ecb721dso953612a91.3;
        Tue, 10 Dec 2024 03:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733829748; x=1734434548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgG0y341Sck02mPUDWmT12vY0FvtCZ22l4JyW9IBLow=;
        b=ArgRMC69LwRA9rYAi1786wsRS1EW9wFnQAuBzmVVFuMMwnCFVb6uF5jggkVjFVaizl
         1xH4l9URC5ZyWP7XylQ4RE88GRCwfN/1nINdociPBRphrbm/WQAC/MSJtG3jY+2ydWQV
         ZgkNAXehAdCnBzuOaIThAV+UYUU1rqW9P7Wc5EcwT2kGyEnnyAiZXtBB21onoaAO64Pd
         84mZsYYaGTr6kVXfGOFT70XpWA023l7dPcsgbFVnq2dS4n+cX1CW6f1AUZtbIIHw20Xn
         6zvpsB7/CVo89bug8eW4C9J7Mm4PAgX3LTcdGH1pf2vSwyqmVzJhh+Q+9c5o8gS5NRar
         Qrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829748; x=1734434548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgG0y341Sck02mPUDWmT12vY0FvtCZ22l4JyW9IBLow=;
        b=YVEdwySvnZbywCTBQHKLpAYiv4ZaFOCfhmEfkcZpCZYheCHFQ5yid/Wy5n8rSrbawm
         MqIsr/1wWp8WS45/WWUO3T1n5yLLpWAPIEcDw8vnJalulVjqlZt+DrPOnzPoMZsTMbad
         2pJF+hrwOvnwyU0GHnCD/rSGSMPy9XKynHVK1jKtHUIEsxrf+QfZuiooYEcQL+6qwcPT
         tH5mPLKzxEhKw9k0Pn+K1xuTfbsI4DvMUplSD/3YnSxR/XhAAa7+GIF75UokHit1Keo+
         Rtq3iIhdebjcQLCf5+68YJxkZ6APqsMM+tiexrcPE0zaOWTtGv65S5dU1QK/GQHkFm3h
         xPIg==
X-Forwarded-Encrypted: i=1; AJvYcCV1FuQbU3yiRcx1BvzgV7zCvK2zCKIU0zA5x1JDkEflmidYsNvJlsDMpxeps20IArse4xT0wVm5w4b+Q4o=@vger.kernel.org, AJvYcCWtKBQuNmNJZxXto+fbR2bFg074gF0ctikpA/+CNdy4l+d8ENnvaXbMJL5+mbeUl+JcIGdLQGW2QUHfbuJnC+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrDX0RQ+xJmDxqsVlO0qKAT5Suph6i3VBNaEIyI/4j1ifXsVAu
	DNqygbDqa9tByQ2xMJ8/pliSKTu8kaZysx/AMhXha4lG6CAf+zENQq/ICIi0eFiA8AmgWmDJ0Lq
	Ct8irj+Q0PVFPCcMkeZVYRx1gLvY=
X-Gm-Gg: ASbGncsHXU+0aLoq3LY9iBI1WxXPJJvJE5sx9kOgCfRYAFUGwYHVXySUoI4XK3B1+mE
	P9MUNrCLR6N5TJ/SUnXwNgGXrXg1MDNZntEE=
X-Google-Smtp-Source: AGHT+IHN1GBS4IwSD9SxPBjx4NqXatH277WbNemrsELKNmm0wInRfz/RKQEIi2WuTdsL/tVB5b6oso9v+BlE4j3qmeo=
X-Received: by 2002:a17:90b:1e08:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2efd4a1266dmr1879889a91.4.1733829748304; Tue, 10 Dec 2024
 03:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203051843.291729-1-jtostler1@gmail.com> <CANiq72ksaJcpjHi8=vuWLTLLfik9smaqY9oJXjwtieXgJ6Gy9Q@mail.gmail.com>
 <6c1ccd07-1a42-43bb-9162-0d6401db72fc@de.bosch.com>
In-Reply-To: <6c1ccd07-1a42-43bb-9162-0d6401db72fc@de.bosch.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Dec 2024 12:22:16 +0100
Message-ID: <CANiq72keOdXy0LFKk9SzYWwSjiD710v=hQO4xi+5E4xNALa6cA@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Add doctest for `ArrayLayout`
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: jtostler1@gmail.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:57=E2=80=AFPM Dirk Behme <dirk.behme@de.bosch.com=
> wrote:
>
> Slightly off-topic here, but should we try to document that somehow?
>
> What's about something like [1] below? If it is ok, I can make a proper
> patch for it :)

Sure, please send it! :)

(In general, I think we should avoid repeating "general Rust
knowledge", but as long as there is kernel-specific content, like your
paragraphs below, then it is good to have.)

> +``Error`` as its error type.

I see this first part comes from the `Result` docs we have, right? I
think the rest makes sense in Doc/ as you have it; on the other hand,
we try to avoid duplication. We could perhaps move everything to the
`Result` (or `kernel::error` module) docs, and just link it from Doc/
-- that would give us the ability to easily have intra-doc links on
the methods like `unwrap()` and to test the examples.

(I noticed because I was about to suggest linking/qualifying the type
above, but if we had it in the code docs, we would already get that
for free.)

> +The ``?``-operator versus ``unwrap(``) and ``expect()``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Calling a function that returns ``Result`` needs the caller to handle
> +the returned ``Result``.

A (kernel-specific) example could help here, even if "abstract", e.g.:

    fn f() -> Result {
        if ... {
            return Err(EINVAL);
        }

        Ok(())
    }

This immediately maps to the usual approach in C code. In fact, you
could add the C equivalent here for comparison.

Perhaps even give another abstract one where kernel C would need
`goto` to cleanup.

> +This can be done "manually" by using  ``match``. Using ``match`` to deco=
de
> +the ``Result`` is similar to C where all the return value decoding and t=
he
> +error handling is done explicitly by writing handling code for each
> +error to cover. Using ``match`` the error and success handling can be
> implemented
> +in all detail as required.

Another one would be great here too, so that they see the verbosity vs. `?`=
.

> +Instead of the verbose ``match`` the ``?``-operator or
> ``unwrap()``/``expect()``
> +can be used to handle the ``Result`` "automatically". However, in the
> kernel
> +context, the usage of ``unwrap()`` or ``expect()`` has a side effect
> which is often
> +not wanted: The ``panic!`` called when using ``unwrap()`` or
> ``expect()``. While the
> +console output from ``panic!`` is nice and quite helpful for debugging
> the error,
> +stopping the whole Linux system due to the kernel panic is often not
> desired.

Perhaps link to any relevant C side docs here.

Perhaps we could also mention briefly other approaches used sometimes,
e.g. `unwrap_or()` and `unwrap_unchecked()`, ideally linking to the
Rust book or similar.

Thanks!

Cheers,
Miguel

