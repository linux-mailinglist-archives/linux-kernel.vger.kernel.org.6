Return-Path: <linux-kernel+bounces-571821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E32A6C2C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DF9188D904
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90622F164;
	Fri, 21 Mar 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjig29wJ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B113C914;
	Fri, 21 Mar 2025 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583012; cv=none; b=NXCsHDRGz0bYYYIWIVA9HJHMc4kBjQAY6TAQUDNZakhULXmP3nGns/4XuPP50PTFlp3cQ5FyvONefgYCrXZRpXmBsb7CGYBUxJYfgq9JMqX/YCAoAR/AeDHxkqzAXkbTlENqfFRk/CtS2Pq23FiJsIdxBwsgDSS2g6kvDeVblJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583012; c=relaxed/simple;
	bh=PAq4YSXlLH92f6ljS7pmGtSfDM5r2ttCPvDBxri8m18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdxnFcKtT5F3lCcknYgkVKKhj4+fWhn8QVmn4/TQeUeFl1C8yyfH7LArQ8yG6Q1FSBpi94I6UgS/1cMa+/SEXGVWoG9VmDAQAMZwPO9pMOMHOg+vgmyxyE98eydzG6qyYrVWAe9lCVUHb4sKPqwEtU2JlYt6wrTdl0Pop3zMSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjig29wJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so654244a91.3;
        Fri, 21 Mar 2025 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742583010; x=1743187810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAq4YSXlLH92f6ljS7pmGtSfDM5r2ttCPvDBxri8m18=;
        b=Rjig29wJgCnOfl7BwsgjE3GFaZIQXoMOvMkDFdO/yWOtzw0pt7ZTY+UF+xMisA4+EP
         ljVJYK8ehG5f0/e7C1xFmp4UAziUPvh+JDP698+4FK92xdxNO43oOjuJOHTbgXkYEDp3
         36tygtNOcH4l0jUor52BAKtvgHeGtZiciLoYYhqiXfzw5b+mqt+A/cdrsMzz0YGXkbHp
         51sghcv/wdghlpXvzKBN63+HfsIrvwnOeRNz5KklD44dPkTYtFbSniLgRNUDXzfzlbQO
         9RzbqL6qOWmylEfJzD5DO5dSee1xFSUUpZ72SrVFekBdoAW6u7xXHq90sLRKAfR4by7h
         Nyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583010; x=1743187810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAq4YSXlLH92f6ljS7pmGtSfDM5r2ttCPvDBxri8m18=;
        b=Ak9b+Vf1uvYaRhO7ooyxghY6tcRRRqwnhM6cZxtsZspPcwNbHpiimkCUNVdAqfMHcF
         N2mebYfVrpKkk/rIpDwF6R5ZgKaw6uWK+ffoXfjDl5hkUN26acS5iR+YDBpWaA7vMtmy
         I971dswGJgPcuqkw1B6Q7NLgrgLqBAyxsKM7MplpUiJ+byXEbeJpJ+JkgIOBnV/DJHXS
         PdwQ53V6gQMr6GXg2a4vORnSCr9b3X62eWVU5cuxS6Q831Sqdmv+CVNqZz68Bk6qqhGG
         FIbnvmmSj6QxnLj9t76g8GJbVUNHNU6ZuVcR6NzI0SLZkG75fvZPQ/xiiOze8z9Qz/Fk
         1xDw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6hzfLnMkQFal2SHf99LoiBHKQo7bICgTVwmF7amdVYTKJnu043PcJxuVhog9xC5KGZsphqJ/we0jX1hGBwU=@vger.kernel.org, AJvYcCXstENHr575DdkZtBNarHdAxMeP2sXoJZ9NV73QUnNlsZNIbifmZTAxhHgQD4DGCAKx53Eie2QdBWG5uhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13n0xfAgSy1EOpl+l4NejXuswLt+RlIJjbfNM0+qnxXn90mV0
	6dSnDzoW20FAZ0QMXe5Qq9CzLfa8AzyxEwwjG7ziOQW702P9HLiw937Pmpcg02xRMS806bUOGbA
	BT9Ijka55RHgDrnLC2koGtJObuoA=
X-Gm-Gg: ASbGncu6Dxdy6xyDnPyT9Ifs7f2sr/jepKdn2SL1Q7VMzw98S0mz9TqAvmR12TBSLbj
	1Y4qpPCjVJAh0yzfzrJl/Cp3roXKy+qDZAQb1v2nWjTX58V7f72iiUaxM+SQxzTNKyKUCD3kne9
	AjtHs+dUBIx1bxy034NYnlYZP/FA==
X-Google-Smtp-Source: AGHT+IFZTxovkwT+vDiPvlu9XVghR0Bg3UXmwzcuOoaNC/Hfewejjf04kI82WgRv9nDG6XEPA2ggYqyAA2z4UTaw9zo=
X-Received: by 2002:a17:90b:3a90:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3031f4eacacmr874973a91.5.1742583009924; Fri, 21 Mar 2025
 11:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321111535.3740332-1-bqe@google.com> <20250321111535.3740332-4-bqe@google.com>
 <Z92N8dyIE42ROW2t@thinkpad>
In-Reply-To: <Z92N8dyIE42ROW2t@thinkpad>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 19:49:57 +0100
X-Gm-Features: AQ5f1JoamPxaZDszfEleFQXyjzGMmWaW9WuNHZ-MmlZmGQBEto1yEIVCBzHA7QA
Message-ID: <CANiq72kYzx7JTVqrJuP0Wo9=1qtaN7s7fqkD5DDcjA59SgMizQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] rust: add bitmap API.
To: Yury Norov <yury.norov@gmail.com>, David Gow <davidgow@google.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yury,

A couple comments in case it helps regarding the docs/comments discussion..=
.

On Fri, Mar 21, 2025 at 5:04=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> In C we separate declarations from function body with an empty line.
> Can you do that in rust? Can you point to a rust coding style? Do you
> guys really use 2-whitespace tabs?

Please see https://docs.kernel.org/rust/coding-guidelines.html.

You are right that the example block you quoted should have the
formatting fixed.

I am not sure what you mean by separating declarations from body here.
I guess you mean variable declarations in C vs. the rest of the body
-- in Rust it is not done, i.e. declaring new bindings in the middle
as they are needed is expected (and sometimes needed).

> I think I already asked to make the test a separate unit. It's amazing
> that rust understands scattered commented blocks of code and can turn
> them into unit tests. Unfortunately, I'm not.
>
> Please create a separate unit and test everything there, just like we
> do with normal C code.

APIs should have examples, ideally good ones etc. The above looks like
an standard example, but maybe I am missing something.

The examples are meant to be documentation first and foremost, that
happens to double as a test (so that it does not get out of sync
etc.). It is how we document everything else in Rust, and in fact we
are becoming stricter in requesting more examples when people add more
APIs (otherwise they never get added :)

If actual tests are needed (i.e. on top of what examples provide),
then we just finally landed in -next `#[test]`-like support, i.e. unit
tests that can be written separately. We try to have tests as close as
possible to the code they exercise, too, but in some cases it may be
best to separate them (e.g. if there are way too many).

> For find_bit functions we have a lib/find_bit_benchmark.c Can you add
> a similar rust test, so we'll make sure you're not introducing
> performance regressions with your wrappers?
>
> Please don't use KUNITs. It's not ready for benchmarks, and tests built
> against it don't run on major distros.

Cc'ing David here in case he has more context around this...

I agree having a good "integrated benchmark" system would be nice, and
being able to mark particular "tests" as benchmarks etc.

Regarding distributions, it sounds an orthogonal issue to me, but I
may be lacking context...

> Are you sure a public method description should bear implementation
> details? I'm not. If implementation changes in future, the public API
> should stay stable (yes, including comments).

To clarify, it is describing the invariants of a type (i.e. it is not
a method description).

The invariants in some cases refer to private details (e.g. typically
a field), and whether to allow that or not is something we discussed
several times in the past.

We went with allowing the `# Invariants` section to refer to the
fields of a type if needed, as a practical decision. However, if
something is a "private invariant" that others must not rely on, then
we should still point it out explicitly etc.

I hope that clarifies.

Cheers,
Miguel

