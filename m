Return-Path: <linux-kernel+bounces-392990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B859B9A79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B141C20DEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE681E3775;
	Fri,  1 Nov 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVs+geFY"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108619B3E3;
	Fri,  1 Nov 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498012; cv=none; b=ivENLGJmibTmj4tN2+lf/oXVcU2/8WT1XP0nRk4Ts4DVduyLKoTiIIiTwleaNme2dIJSDV/8WYEyLfWezRXVA+cnB8t3wm6hCraTE/YBAIKRVqnT9Hekv5uL5grPj9GOTM8tzYfFF1qAfZR9kQc/6O0FMs7iFd4GpR/luogFYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498012; c=relaxed/simple;
	bh=IZdZ6VXEanQmS5aew0GTy+jBEAFwB31oJoDQbvCC9c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPODW3AE56qTYxan97kUkbfFpejgeXggi2Gx4e/lrfVHhtq4hI5N7GMIZIKjsnTrCm/a6McVZ50LBoMDLCmBGc7ExLmpc3fK59AmueP81xN2Q3FBHQeGXEz7qvPycnG+7wUeliQ5WbB2QAQ8Tvfmx2ar+OzPSo09axI+WK5MYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVs+geFY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c9d8563cbso1720205ad.2;
        Fri, 01 Nov 2024 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730498010; x=1731102810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqYwLVYCa7JtRMAY7L0dqHTnkU3lG0gdXzLLQWwhxDs=;
        b=OVs+geFYukywTmpGykw65yRFlUG6Cjs2Xkb1V7VeyITcHBwO6ng/Hg/7zuvFhp5DSb
         fnfiKfURZp/qlFq9jzXm00TEdTzKvvpMD53TuNPRWjzrQnHT1GD+nK/bnQSgW/r8lUI0
         Wn/CsRediimrml0DZWc5eoGUeC/nD01sr+IycA/XHYBhHWOcT8PRJzXlgr4MDw0mwk+u
         dSqA5FZlnVrkw2CEq6t/uM/5xMpLnp4xz+rEErytifBQgp47YdF3SHLaPweJVLeT9cn8
         pnRaTTO/ofNIJYqejPehbvqMVOvMViiOHxfLGdH0fWLrtwJF/VvWMQQmKrLxCgUNTjNk
         r+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730498010; x=1731102810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqYwLVYCa7JtRMAY7L0dqHTnkU3lG0gdXzLLQWwhxDs=;
        b=Q5vxDYNATNZzBxwL5q5vHubdpWfWmCQANfea1QcFMUVEKLLHGuohXERvmPQW/SYMbv
         wLxDR/PFPM+OyqYZ7fpvUpwwYXLsA42YkReXjwyK1WSKbu+OSMEgOHyeCj452upypm+I
         e2H4dGdAClqNzc2Rshl3LzaGyWDFKlEHyt2t0CJdYx27DGTq8BKr++FPFM7BYL8lcvmF
         BR6x3TZODEianrBT1TFCDMhfbmfJLR7LiralK/J+Wg8RopygMRSepq01/PyWl8OEAoS4
         lkYr04/2FSOef35AfFsk32T9Jk+/ndCsRKJRJ7R/Lq7G+vUAHwJI0ll0axZLpmcZTcgV
         +HYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmCD6GSJNNRAPZV1rspHPtJ/wggR+lN6NkAzyuiZazahQfvm7aGXagS3pvmEQFnr2RSTD9NhmyAF1oXUTpDcI=@vger.kernel.org, AJvYcCV3k197+dAuy61c9+iaKoHi+oJjT/3Oi8WB1brhf+pq5F00quTfGIP/cFfllao0DSUROqaM1LbNZQHv6LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyolzzVRamHyT0JFUz+gPNzkqFXwZNff667O7HCjA6HEIz5OnI
	oNqqSxVYF2eptfhCybn+bL/j5didKNczAToYHbyZYMLVIBmwhtmep6FWsmJAo8a+/ieCV1Q4lLw
	Jyqr7ugwRRYvbIYrDuyHiUrpnKC8=
X-Google-Smtp-Source: AGHT+IEc1aTXPvVEUSIoKCLoAmYgk4WBu38+9EUhHW7R0qMkv+fThruAveeyX4iyfF2oG6AR2Z0eD85EMHz9Qf3XGKQ=
X-Received: by 2002:a17:903:244c:b0:20c:85dc:6630 with SMTP id
 d9443c01a7336-210c688651amr151312905ad.1.1730498009889; Fri, 01 Nov 2024
 14:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704145607.17732-1-ethan.twardy@gmail.com>
In-Reply-To: <20240704145607.17732-1-ethan.twardy@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Nov 2024 22:53:17 +0100
Message-ID: <CANiq72nvVb-SG_M6KRpuYP9kYA0qwQ7faVtavgewzF+ZHO95Rw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Enable rustdoc tests for the macros crate
To: "Ethan D. Twardy" <ethan.twardy@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Aswin Unnikrishnan <aswinunni01@gmail.com>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 4:57=E2=80=AFPM Ethan D. Twardy <ethan.twardy@gmail.=
com> wrote:
>
> This patch series addresses GitHub issue Rust-For-Linux/linux#1076 by
> enabling the rustdoc tests for the macros crate and updating kbuild to
> compile these tests with appropriate dependencies respected. Reviewers:
> Please pay particular attention to the Kbuild changes in rust/Makefile.
> I appreciate your time in reviewing this series!

Applied to `rust-next` -- thanks Ethan!

I had to rebase it and simplify/change/clean some things here and
there as you can see below, so it would be great if you can
double-check the result in the branch -- please let me know if you see
anything wrong!

    [ Rebased (`alloc` is gone nowadays, sysroot handling is simpler) and
      simplified (reused `rustdoc_test` rule instead of adding a new one,
      no need for `rustdoc-compiler_builtins`, removed unneeded `macros`
      explicit path). Made `vtable` example fail (avoiding to increase
      the complexity in the `rusttest` target). Removed unstable
      `-Zproc-macro-backtrace` option. Reworded accordingly. - Miguel ]

    [ Rebased (moved the `export` to the `rustdoc_test` rule, enable the
      firmware example too). Removed `export` for `RUST_MODFILE`. Removed
      unneeded `rust` language in examples, as well as `#[macro_use]`
      `extern`s. Reworded accordingly. - Miguel ]

    [ Rebased (one fix was already applied) and reworded. Remove unneeded
      `rust` as language in examples. - Miguel ]

    [ Rebased (use `K{Box,Vec}` instead, enable `lint_reasons` feature).
      Remove unneeded `rust` as language in examples, as well as
      `#[macro_use]` `extern`s. - Miguel ]

I think we could also simplify some of those tests (I think the
examples are clear without so many constants), but I didn't want to
introduce extra/unneeded changes to your series.

Thanks!

Cheers,
Miguel

