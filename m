Return-Path: <linux-kernel+bounces-392690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C69B971E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E0EB21845
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154A1CDFDC;
	Fri,  1 Nov 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/By8LQa"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821BD1CDA27
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484513; cv=none; b=NH5iYXy6Bf3sx+PvMEbgjp6O9sVHADf12Plc9xDHWgPXXG/ZoVGg3bL5gjxyIDGSVEyjNa77bKYkUSGXfthgNpBiDt1e11PHmewCJwyXRJU67GE6tjjiZf5tLPOkbz7VL+0C+fCQu5u3wakvwPe4R0qCn4IvY8O2aN4ig18AsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484513; c=relaxed/simple;
	bh=wTIyBZgnq62le+5w+4w6X/ecvgjYY7nVJQm7gIAKPEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkW66yWTKVDr5TZQhhz6hDloHbQz3xSZ6f7vcQWK2jxC9B9gE9sInb+hyklFZZjQOnD9C4b5ZOElrmPaI9Fe07dNZloSz8FTJvBlGP/Cca5xn6T8FPYETnLZ529uCHD0bZIIZc5rFW/PZka/MLpztxiWMv9Xkn18OGxsiCLj0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/By8LQa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f72c913aso3760343e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730484510; x=1731089310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftGl4XcG9OH9sBgHhSBECZNA4rpR1fv1xw6T+vkOgXg=;
        b=R/By8LQal/cP2QNy8QNLePJe70GiELBbBDG4kdIjFxTkxjdTdqDW2TK2emZM1g3Ct9
         Rx4PIGkqTSTKdYwHMinNl/ac7m0qipBx5BuszxO7giFyWRAh7iR2Bhdh8LChdsKGnINt
         x69tHtYqAFWQfpuU4xT1/muUv1HtBw0NcBy91+0xpPXTag6131doxbfZvVVV1HUqCvAg
         HjZ5stQHnhkm9boW1PxpY3Wyj0r9lwwkzLsKmRmlIbAkRF9Z0FfyEhSkNEPrMSG2GuUr
         EH5evwtskvzfNvxYCc49kuHTctYTB5FZW0v80J+113BRaoRKHVZwMfYkrpCebZ/oXi1M
         3ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484510; x=1731089310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftGl4XcG9OH9sBgHhSBECZNA4rpR1fv1xw6T+vkOgXg=;
        b=R+oLki+08btaCUgz1E3HckGid7Btp5XeH8U23SR5ZmTsakNpAc4qYyz+be8ZXsX1qg
         0xcnyl2xg4309ATEgiqklWMY6TV+Uj8fhmbeDc0YRsoM8Z9GdmMJtMtldW/iYaj1FOLY
         Doiyt/TgoGsU6vJVoIUgHHzn1KATB5jHpRfO0E4Eli2pFQr6j0+RV7PUOmBi/Zep7jw/
         FdEXF4VVz5Td7AVs+SDRArX5q7JYN9qC+Pagk61hUiYIrMXNwPYQI07NPZSLm3mgasMK
         jaWxQqES46Ql3R6ouhIN/sUoI7nkYeK3U2QfgAM4TQWWnBepniye2XgJVNbXrEXNr0ui
         RrBg==
X-Forwarded-Encrypted: i=1; AJvYcCVuSGvotBWk7JwE/+s0/qs/pbsfj3eRuyZzjeDmnYnvzWyPwjJOS7d1YezwSGshLLaVrCPg92WD4ahzmcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdArZrUpfVWQzFSifho6xTa9VH3quAZibPFOxksUFhWky4fBpF
	AmbGW6nhXQfEkxX+qSbdtI5GDBtdIikJsYE1WrAoqUHm5WsaYL84gykyMTB9jbKXk8KbxBIVGRV
	kRIqO49c7jzV2KIE3IWvadh+weIgwDZEVHHiF
X-Google-Smtp-Source: AGHT+IGwMCf8aDQDescU4zGGm+ZBhK+ouK3E0Y7btO9KyPPQ1vu6pGdaYG4lHllgWVIGE4uaJ5FRjGI+iaX5NJvPKXo=
X-Received: by 2002:a05:6512:b82:b0:539:fd75:2b88 with SMTP id
 2adb3069b0e04-53b34c46711mr12231661e87.60.1730484509488; Fri, 01 Nov 2024
 11:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
 <CANiq72kcvpEqpwFTNFmxfJsfBMeBNiDrrvFBf_iS7+ozaECJzw@mail.gmail.com>
 <CAHC9VhTQMo11s7mWg=zzDusJompOp01uJat-q9HjQCoEWzHRRQ@mail.gmail.com>
 <CAH5fLgi+JJHCA_XTPC0-kaacZC6=aGSa-+DiNt06GSJNFhKc3w@mail.gmail.com> <CAHC9VhSv+ro9gOzanvPS1gZwLkqO7ZoZk7SOZ64FP+-sdmYs2Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSv+ro9gOzanvPS1gZwLkqO7ZoZk7SOZ64FP+-sdmYs2Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 Nov 2024 19:08:16 +0100
Message-ID: <CAH5fLggDWvR4i8L+Hin3vzOYnsP2jwZRS7cK-B=xjjOwGBaKkw@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Paul Moore <paul@paul-moore.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, naresh.kamboju@linaro.org, 
	casey@schaufler-ca.com, anders.roxell@linaro.org, arnd@arndb.de, 
	brauner@kernel.org, dan.carpenter@linaro.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, ojeda@kernel.org, 
	regressions@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Nov 1, 2024 at 1:24=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
> > On Fri, Nov 1, 2024 at 6:11=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Fri, Nov 1, 2024 at 1:04=E2=80=AFPM Miguel Ojeda
> > > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > > On Fri, Nov 1, 2024 at 5:56=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > >
> > > > > Thanks Alice.  Would you like me to pull this in via the LSM tree=
 with
> > > > > the associated LSM changes, or would you prefer to do this some o=
ther
> > > > > way?
> > > > >
> > > > > I'm going to merge this into lsm/dev for now so that we fix the i=
ssue
> > > > > in linux-next, but I'm happy to drop it or do something else, let=
 me
> > > > > know.
> > > >
> > > > Christian has the VFS side, and both are needed for this -- do you
> > > > mean you will cross-merge vfs' branch too?
> > >
> > > I think our last emails crossed paths.  I'm not going to merge this
> > > via the LSM tree as we don't have the Rust security.c helpers.
> > > Ideally it would have been better to have the Rust LSM/security
> > > helpers in the LSM tree for reasons like this, but it looks like it's
> > > too late for that now.
> >
> > If Christian is okay with rewriting the vfs.rust.file tree, we can
> > drop commit 94d356c0335f ("rust: security: add abstraction for
> > secctx") from there and I'll update it and send it for inclusion in
> > the LSM tree instead. I'll need to drop the piece that ties together
> > `struct cred` and `secctx` from the patch, but I can follow up with a
> > small patch for that for the 6.14 merge window.
>
> I can only guess at what Chrisitian wants to do, but my guess is that
> he isn't going to be very excited about rewriting a VFS tree at this
> stage ... which is very understandable as far as I'm concerned.
>
> I wouldn't worry too much about this right now, I'm going to plan on
> holding Casey's patchset in a staging area until after the upcoming
> merge window.

Okay. If Casey's patchset is not landing for 6.13, then the fix I
posted initially can be used. Casey is also welcome to squash my fix
into his series if you all prefer that. I'm happy with whatever is
easiest for you all.

Alice

