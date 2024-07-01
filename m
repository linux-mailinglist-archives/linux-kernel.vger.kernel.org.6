Return-Path: <linux-kernel+bounces-237067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB87591EA90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AB51C212F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF2171E5A;
	Mon,  1 Jul 2024 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+7cEjw/"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD1171657;
	Mon,  1 Jul 2024 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871113; cv=none; b=vGOARLzt8upmCLDBSL7t/xSFZl0ZGFNZUsYhL9f+ZuQFa9ROyvOqO4LXllKBD045rb7YKoNG6ApF7eHDaouddCKtbsbzbECvZcIHO6z4Qy5SrfoRtKNpYY4StzljQU3ZZPW4iW6bJ1/h6XPO3DheHkAJYu6sBWiTSOtuBRgXsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871113; c=relaxed/simple;
	bh=tlQGRW1IcR2XLrHRJ5fJHNgvknF+VsqTTtXrxqai0CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIvb7XCExxnJMHvjrP5itxnDqHd1yNlie7YY7rYYBX5KRoDDoMn8dTzW+wIO+FpcBmMVUFm9GILaOQWcNoX7vGfxY/GzWv95RrMe1+/zlW/TsbXSE0FFSPSZb1A/8iWW2V10EMtKyvyp/9jb1ubqJQs1tYYR31VL6bMIcgG7uQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+7cEjw/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c70c372755so2310496a91.1;
        Mon, 01 Jul 2024 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719871112; x=1720475912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlQGRW1IcR2XLrHRJ5fJHNgvknF+VsqTTtXrxqai0CA=;
        b=b+7cEjw/dpKYqA+NWkYx59gEVc5ZX3cCTMVnTpGvNsPi2tMG4gnov85cX9qaKQJYaP
         1WZIyJ+xwgT3DGrZCMlrr2ULTMMlV3olMd1ceUrO6Gcg6KWhTTWDYUjDBxq//FnGSGXq
         t+dsaxdA0FkUdTCkCIOLheXhGC7tURsn9EtJoUsoJA+XpOZXP/+HHK7sEl0DGVx3U/57
         FKzLBp1aUJRgd9+TMuS0o2ZsHOtqrbl5jr1q290ciCEFYiC7EpWR848XYa3doaPW65lO
         +tNvuUdZJ+wkjOzP8JZSFWom+O31dvSOzDApSRTEcWHigBqaQgXsCBMNrYza0yiE/yug
         4Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719871112; x=1720475912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlQGRW1IcR2XLrHRJ5fJHNgvknF+VsqTTtXrxqai0CA=;
        b=Oj4CR8e10Nu3tN/GU9nAr+fcW7tCyBZSjrRi8z5nFT/hCV06CnOroPrQC3keHdozXE
         OLezA54bmtf6VJAhL4Wf5XwjVkgRIRZxafsju0IxqXzpjQ+n79HC9UYDoZwhP/vF131Q
         ZqoqwDjk+2ofei0v+quLntSqXE1Ok1XCr88Mq64iz0XBxc4mAFDCDL2S/Z30/XBWFEhc
         bRFoVy/i6NVm9b9lDbsul35OfYB7s9nQwNLbrGi34h5KewcMgcX0+6W2IJcs++Yi1rL5
         pmmpanbjV+OAQjV5wKVHEW2xxf7GljbNGnaYyoHFHZDRh5Q2ZUvPbi4tLwvc9i4HvZRW
         SnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX2uY61oG21Ti/CpxP0zAXZcYmFW0P/jzQPO9ndsjnF+w1rdDvZwlkVFM9qTWCx8JIsn5DN93TaJrtPECFO1CMPdiMSVo1mzHVqp3MKR8TfwPboUuKcHgIaZO4SR+nbOaJicuxMkzEOMk4ThI=
X-Gm-Message-State: AOJu0YzLtbtpRRoqtXUAsETj0jFxTkcKGJ9kG1s0syBBG/3+BGJerB8W
	eERHgWjANVZo7rP4HwxeMG4csgRVzGr7mxjgU55g+boQ7pGpAf/KShBmNK8Jy4AW/nJoWFcbefO
	5txMXUqbpwD7hmjm5Upy//k1ktkw=
X-Google-Smtp-Source: AGHT+IFrP259sfZ8yGRxwucM+31Wr6lNtpD3kv0GbUgMjP0oJ5e5qH0ThJSRx/+w2HTAmQtLrbU7L6R2M0upQgm0mj0=
X-Received: by 2002:a17:90a:5890:b0:2c8:5cb7:54e5 with SMTP id
 98e67ed59e1d1-2c93d79abaemr3418146a91.32.1719871111661; Mon, 01 Jul 2024
 14:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701183625.665574-1-ojeda@kernel.org> <20240701183625.665574-3-ojeda@kernel.org>
 <ap7u5hpgfdzYgTkobIleYc0uolBIsAVbq56CwMJG6k4x57wXeEtu4fpLpgSOvQtbJHvB6D0J1wlBaqDV-xt2owlVejhfABUv_ivILyJ2J9o=@protonmail.com>
In-Reply-To: <ap7u5hpgfdzYgTkobIleYc0uolBIsAVbq56CwMJG6k4x57wXeEtu4fpLpgSOvQtbJHvB6D0J1wlBaqDV-xt2owlVejhfABUv_ivILyJ2J9o=@protonmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jul 2024 23:58:20 +0200
Message-ID: <CANiq72kMaPm2OsGb3o0VUtdoMhSUoo8QEsCFzVjYFtCThvNJ1w@mail.gmail.com>
Subject: Re: [PATCH 02/13] rust: init: simplify from `map_err` to `inspect_err`
To: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 10:05=E2=80=AFPM Bj=C3=B6rn Roy Baron
<bjorn3_gh@protonmail.com> wrote:
>
> The formatting here is a bit weird. I would have expected the ) ending th=
e inspect_err call to be placed on a new line given that the unsafe block i=
sn't placed on the same line as the start of the inspect_err call either. T=
his seems to be a case where rustfmt mostly gives up on formatting. If I de=
indent the comment and unsafe block rustfmt will keep it that way and if I =
add a trailing space to the inspect_err line it will keep it and emit an er=
ror that it left behind trailing whitespace. Maybe add a block around the c=
omment and unsafe block to make rustfmt work again?

Benno: any preference here? Or even open coding it.

Thanks Bj=C3=B6rn!

Cheers,
Miguel

