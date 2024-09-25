Return-Path: <linux-kernel+bounces-339505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C521986616
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B17289DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57080135A53;
	Wed, 25 Sep 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAAoTEdH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79563D520;
	Wed, 25 Sep 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287296; cv=none; b=WseUxgb691vDJYPyw7uWFeSiiFXrm6NLLqMc0zM9TYUpu/2tZuxMejkkVTFuy91ndVOnDpvwfAsWLAvClCYgyB8Nhn4aMoLbtCPNDXWIb07s5wf2q5RJCjkXYBaSrz1/DMeq7It9+SnB23d/2jFO/2Ik3rX9m7zmOF4XhrN4x0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287296; c=relaxed/simple;
	bh=l/aF6HEje1WrQejJhMguPF74uJK65A2E6ZnTaqz0qh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLgaar46F+r2Bi2DcnFcojbzddPVXLWNroxxmfv0jtDuWCpU/2Z3XDUZE+puJzInsjTk7G/ICT7+q8Toi4ziEqWlLm3Iycvrt92LCDqJqOcWEdGFUaMArECUSfNdj/vcHeaPSIlCuqQzDoQ7Ow1r3mkRoQNaIKzgLeQn91X0wGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAAoTEdH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718d5058819so17232b3a.3;
        Wed, 25 Sep 2024 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727287295; x=1727892095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2bMVMMQFiHMYlO4kJ4Jsrotx2zHLunmyL9pDwTWohM=;
        b=PAAoTEdHGPsybBTaweiTVmjQmZzGb5haTg6wKCnGNANEzjqUlTbTjABZ/WyQX3Trr0
         b7jb1YWTaqbJdp5WbcqVPwKHckBS/ZDmHHLDAAksHW1Fs1LE1d7Pr8ACE6TzJu1N8uON
         /zhjk4j/NnSteyTvOuZaj0+STzpur6YPVVWvPdEmxwY6KSqwiS4vTsCRZSO8+nq96SeI
         vMVT61NsFnpGrnuh9PgwoMG2J4H4iAaWaJ4DjgNtOV/ONGGK232ZgOZOybqngEHxGJ5j
         UJMjMKfFHiHlKbO6FfoNWV0mwB2A7i200KT0+uo5p1tAobbAi7xj6fXqnmst87I/mYhu
         +0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287295; x=1727892095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2bMVMMQFiHMYlO4kJ4Jsrotx2zHLunmyL9pDwTWohM=;
        b=nCx/RPjDZqcd/Grq9jmABh2e77J36wZApMKmT2GciREoixoAMmngU8Zvrq6U0w3btA
         w9t0CGbrBaWhb15IIbtjVnHkMUd0qtug9NurncTv2NuFTLrFATzrWhz08LDP1ZJnU0UA
         9oDHDLVfg68fLhEZpRfXv1em+2xpxt4U3m3UwSTXAhAwiOH5k6UoVDVnyZWmlEw8yyn0
         fTDyglcN1AYd4wPTBcfWgGPlDvcOqpXGkJsgPrm2t7fgx5IfUkcWNBFF082ose+ButtM
         58TYnsRYKGoKyfFZsfgycth5l1MrgP19k5Z6J1T6ov4gpSbRjquTV63EylHLIQBvJdMm
         uR9g==
X-Forwarded-Encrypted: i=1; AJvYcCW4OcY5Wqgk6ZP/DwtnqNGrqCFlG6p9jYsLoh6GbmsvBtLNASdw7OKEQnS3NABLklG7L1QSL9Q7cGHqtsU=@vger.kernel.org, AJvYcCWSrqBGtQfRf/553tIUzzLRd1hU74KV5UiSQVx8auuf4b1PQnycCBbmZ75be9cq2ivccZHdqEtrwhxie8mPxPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqs+qQydi0MJJbthY1XRpzbc/aIWxKQwEN2S5yraZnY4D1/GYW
	taGpTUaXl2JB/UV/+Gdpv9BkgAduLvSR8CelxLCAN5FHkR5qUFP6uaj9bpTH2agHc2hoAG59itm
	43Fb9dbMSwbtLrE7hbgPAngdiov8=
X-Google-Smtp-Source: AGHT+IFNl0/wFDJTogZurxb0YOmE/SuxjY2UhYxrOQ1JRzNCgdbbGH+ZSOh7oP3wpgG/YRHHBGKLS4FSXYgozxCMXwY=
X-Received: by 2002:a05:6a00:ac3:b0:717:9406:c1be with SMTP id
 d2e1a72fcca58-71b0aa94ed2mr2271225b3a.1.1727287294372; Wed, 25 Sep 2024
 11:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924221023.197610-1-ojeda@kernel.org> <CAHk-=wjuMrUMceYX01T0SBz4E0yL4Kh2Jb_8qyKxJwwitCG6Zw@mail.gmail.com>
In-Reply-To: <CAHk-=wjuMrUMceYX01T0SBz4E0yL4Kh2Jb_8qyKxJwwitCG6Zw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Sep 2024 20:01:21 +0200
Message-ID: <CANiq72m7ZcmQdq+D37N-bmH_JeFg7H+HUhJJnWTdCyZxn0hkMQ@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:46=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That gets it building for me on x86-64, at least. But at the
> maintainer summit I think you said MODVERSIONS support is being worked
> on too, no?

Yeah:

    https://lore.kernel.org/rust-for-linux/20240923181846.549877-22-samitol=
vanen@google.com/
    https://lore.kernel.org/rust-for-linux/20240924212024.540574-1-mmaurer@=
google.com/

> On my arm64 box, Rust support is still disabled due to
> RUSTC_SUPPORTS_ARM64 not being true (which in turn seems to be due to
> SHADOW_CALL_STACK support, and that needs rust 18.2 which I don't
> have).

Yeah, Rust 1.82 is not released yet, it will be on 2024-10-17, i.e.
about 3 weeks, and then Fedora should have it soon after (~some days,
I think).

> Anyway, just a heads up that I think we'll have more "unintentional"
> Rust build test coverage this way.

That is great, thanks. I currently do defconfig + a few bits and
variations to cover the Rust code we have (to keep the CI time down)
-- I will start doing allmodconfigs for the next cycles then.

Cheers,
Miguel

