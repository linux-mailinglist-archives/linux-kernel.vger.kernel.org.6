Return-Path: <linux-kernel+bounces-520590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC0A3ABD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1016C1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EB1DB55D;
	Tue, 18 Feb 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deIpflTI"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B41D958E;
	Tue, 18 Feb 2025 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918325; cv=none; b=M20a65dpaCTVe76vsRbtqACOE0zRgXNezDePmDzH5bC1xooBE8dibK4XKj1N6DKuPXDqwSPBl24C3klwPSlU00fa8bqnbPoRx/FeOsegQkhosFFEbO55rJcarZz5lDgvgbQuA/lLICOozFwCNoMQle6qF+GBxZ3DT9gCZma/AE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918325; c=relaxed/simple;
	bh=X/w9dv6WCIb8khQItSdUJ4hRIaz8zS+I0fws+Q13vdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj08Q/sauzfYSVNTeflwxO6jbWXnJtvCRD0PG0L7Z1Hha95Kdgw+46k1Qndk0/coUISnufEjt3ey1cI6dTg6DS/xheGW3YoxzYFYWfXWe0yVXWYx2dzoq1YSGqYreOIOqNsEAqpBfIibPW2rEQ7vW0qHH7oTwPzlFNzyxIn4gNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deIpflTI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso11135790a12.3;
        Tue, 18 Feb 2025 14:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739918322; x=1740523122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/w9dv6WCIb8khQItSdUJ4hRIaz8zS+I0fws+Q13vdg=;
        b=deIpflTIwx7f7okhCxiDbhKDWt6v80xfg2g1HmvP0Le37ApXcjtQIZz771aYIdvIm5
         8HI+10hDcjcg1au1dy+n3f+apETwrKMphdxswTSqgDa8JU4BpyLS7FzfNKVdd3bTAltw
         r6XwfJc83r032uYhxYPq1oWxJKXrCN4lCsEpH9og/KCENt3qRfTjKP1+5C5wyR3DmBGm
         3bKfWZQTJRxwJ7VdEavKHNVEpiZMugEVVXMm/NrJJ1u+vOCazC9zp3VFyV+CK7jqhBtE
         e5DBIoozjUwlrCNHFmnWagRCz/nylM71khS61zuDVSTEXvhTG4id4yWOHgKx2eRigZlC
         VzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918322; x=1740523122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/w9dv6WCIb8khQItSdUJ4hRIaz8zS+I0fws+Q13vdg=;
        b=ZOC4aqiXvzXEQaOuSDrMSLRC8wHljBgpPb/c1LQ28KG+bYd/MnS42aPCdolQvLw7LO
         QlGB6yfJB6GuiitO4sZm1Uqa6+1KaICxMqP2TOf+1cTs4a/wDsQRPcIKEOW4aifbVV/g
         om4De10fE9721IjJ3im/GrCBDaiXCXwACs3Mcat5orfWUJl0biCOmNd+wlaY2SUfGnjJ
         V/n4TTDwETzTqJk3qDFJBoFVZLXtV8PmvEJH1wPUAbEo2fra7vi5y0O2hhNkIWTjM2J0
         EWbPvXqpd3j87e9vj2VDl/ZyU+cBsnWv0ktzecPjyjP+2DGVeGBURL3zUPvhQ8m/2NF+
         /G3g==
X-Forwarded-Encrypted: i=1; AJvYcCUGU/a7kzEhqC0Pyn8bXvDKAARISITKB+H+yV5bxQM2EolCb0A0Qmg1v+vJJZ211YroHP9cz+QafbPGvso=@vger.kernel.org, AJvYcCXpXLzwHNuVG8O8ORietfdRXpQ7TMhF1/R2atgiSWdrouGRkXTRu4NMbytyfV/ocwu0kb+DxsLoHWcb6cvnhHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Qnsoro2WFR9qqovBqVCzPPixOn/KTQ6+wzoioqGUGJCoNedI
	iy0xvwtWaTncvpVowPk/S7VybUwftU95r2wgPziG+5NJiBdTsBGvUfP79laN6QKWh665dqj4e6K
	QjAM7R+YjulotUuZZMWdz4e2XmYU=
X-Gm-Gg: ASbGncsggmD6/c+p4CzUIC4qLf8kn7WWUWKH5cxPOwvaAJmJIY3eiymZrOQYXX1ULJ/
	7Dv+CcWawnSVMqhS26wPOsJ1jlKyyvleE8jEOMgP016lzjQwjG7YDoYxkPetGy13M9GMWJms=
X-Google-Smtp-Source: AGHT+IE0KrBd630x4dCMI73nbxYD+2oUb+XNu+r9g+15xy1qsYaOv1o/LXN3NckjPiVNRFUr2VFrDcLSe32/twzUEso=
X-Received: by 2002:a17:907:60d6:b0:ab7:ef48:1668 with SMTP id
 a640c23a62f3a-abb711c382fmr1511816266b.57.1739918321797; Tue, 18 Feb 2025
 14:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
In-Reply-To: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 19 Feb 2025 08:38:29 +1000
X-Gm-Features: AWEUYZnxnanMLXuDMA2c6TgTwYwzjKTQk_SYXC889XG81ahvm8TLQqszxHmmj9o
Message-ID: <CAPM=9tyWvKcUnP2XJh5G=4nSCjum69phxNpOG8adPunQ+3TNdA@mail.gmail.com>
Subject: Re: Rust kernel policy
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I have a few issues with Rust in the kernel:
>
> 1. It seems to be held to a *completely* different and much lower standar=
d than the C code as far as stability. For C code we typically require that=
 it can compile with a 10-year-old version of gcc, but from what I have see=
n there have been cases where Rust level code required not the latest bleed=
ing edge compiler, not even a release version.
>

This is a maturity thing, as the rust code matures and distros start
shipping things written in rust, this requirement will tighten in, as
long as there is little rust code in the kernel that anyone cares
about why would they want to lock down to a few years old compiler,
when nobody is asking for that except people who aren't writing rust
code at all. It will happen, there is already a baseline rust
compiler, again until there is enough code in the kernel that bumping
the compiler for new features is an impediment it should be fine, but
at the point where everyone is trying to stop rust from maturing, this
talking point is kinda not well thought through.

> 2. Does Rust even support all the targets for Linux?

Does it need to *yet*? This might be a blocker as rust moves into the
core kernel, but we aren't there yet, it's all just bindings to the
core kernel, yes eventually that hurdle has to be jumped, but it isn't
yet, I also suspect if we rewrite a major core piece of kernel, it
will coexist with the C implementation for a short while, and maybe
that will help us make decisions around the value of all the targets
we support vs the effort. Again this is a maturity problem down the
line, it isn't a problem right now. It's also a good chance gcc-rs
project will mature enough to make the point moot in the meantime.

>
> 3. I still feel that we should consider whether it would make sense to co=
mpile the *entire* kernel with a C++ compiler. I know there is a huge amoun=
t of hatred against C++, and I agree with a lot of it =E2=80=93 *but* I fee=
l that the last few C++ releases (C++14 at a minimum to be specific, with C=
++17 a strong want) actually resolved what I personally consider to have be=
en the worst problems.
>
> As far as I understand, Rust-style memory safety is being worked on for C=
++; I don't know if that will require changes to the core language or if it=
 is implementable in library code.

No it isn't, C++ has not had any rust-style memory safety topics
manage to get anywhere, C++ is just not moving here, Sean Baxter
(circle compiler developer) has proposed safety extensions and has
been turned away. Yes templates would be useful, but maintaining a
block on all the pieces of C++ that aren't useful is hard, I'm not
even sure expert C++ programmers will spot all of that, again Linus
has show no inclination towards C++ so I think you can call it a dead
end.

Dave.

