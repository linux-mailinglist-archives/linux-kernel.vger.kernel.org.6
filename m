Return-Path: <linux-kernel+bounces-281595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF1594D89F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D16B22F28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B216B39E;
	Fri,  9 Aug 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL/480GB"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394126AE4;
	Fri,  9 Aug 2024 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241417; cv=none; b=pXObcwPHKZ4iGzopbscZMoxl9Mpz9RMY88iNlyMld5no5f+hb0CwCo+3dU6+jR1gXMsO8DeHBOS7CY55K6MjjS5xG/5Tu527UgfLM0RY6Tflqao/zPGTTSPPLDrsq+Dx9Kks6gA9HL20xeB+HENOHItEKz3StzyhrJmWo80AcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241417; c=relaxed/simple;
	bh=/6oAzynm+O89SmFpSFBiVtLyb8PSMWBWtE1uFS1ZXeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZHez5vJAyTG+IkomEQ0eaKUqlOn6BoCXTpFJbkTYjcP67BqBFGt+FKgzmNt/ZVBbvUAcESbsl3Lkz34it1/RZX2umIFJVbVYUxo49PyrebX2VUHo8ZP+uym1CWs2zXhZlxpyV0ZJ1YCOzL1FA4JxpU7xp0asbXqtIXJ2LF/nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL/480GB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so2044986a91.2;
        Fri, 09 Aug 2024 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723241414; x=1723846214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq6bn9+810fmGeMcLWFGPKfSzMSYz9ZXXvYzXe0BYK0=;
        b=nL/480GBuzmTB8Io/cRJZZVflr/BviWqUkI0xg/7h/uuHdEsfERnwoVwl0buZdLQqd
         5EiIYysO59Gjic/vx3TE0BPgK7uEaReqgjQQezthsrvbl2a0xdyOi0mD1T+MDVS6Ihdm
         gIRnfdoq4ABIgyRCI0Ft29nQyZQ3S1VPd36gpLua5UgBgE77M5ibpXmAL9Ymw2VbuxAl
         mlKtcodgMV6HWjIiubY5w/qtu3hGT1045xuzF5AgRbufXYYiK3mfriJN4YeU30Vz31Bq
         vBioGvFm9NLGOajLm+7deNhQ0zPza8FwR8t2GkbS3Cdp+a02uOetjRPAMqI8Bb1bH6tF
         18Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241414; x=1723846214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq6bn9+810fmGeMcLWFGPKfSzMSYz9ZXXvYzXe0BYK0=;
        b=BfsxpXJXnX0mzfg5j4GgSUoZ12iwpLfMgQEGNT2xhkZZAP1wWFerJZA5ajLuVzv41f
         d97XQfyB4UvZwMWo2Ye2QFWZ1miQ+uIyDFyFDQ3mlfSqVsBNkGSIxbPNG1yjprbEiplk
         FkorpADyTHRmp/DZqNxfHcwa7GdidpvV/J9+fCm8xbvl4fUmX+u3ulTgO8Td8iGw9zbk
         f01k2cgPhIGUc/Ij2dENqxdiOn1KpA49Qgvuite0dvNhdiCrMrr0duAYVEuKi//HuZko
         RsSXkN7aYcXIMFMIVjy1gXFtg8fQ+lw9FuXEAsaZQ+5QhNIbqefjhP9ZarbY+tACl8qg
         OiVw==
X-Forwarded-Encrypted: i=1; AJvYcCX46QxHc7ol3HpabSseQ5f9g5bP00+QSlrIl06nw1uw6u7CBFFXNz7ljAZtTIA0tdSvHrjOm2fSYuUAImweoa8d2icnkrudXMKCNfFez0mfqhk9DGQbtXugnyyY+6z1tgDhNh+j7gucYjj9+D8=
X-Gm-Message-State: AOJu0YzySZtSzH8R2xeUfko8MIx5T7yanXkBpnplTzh0DQE7OqL1Sc4a
	yvJGTZjZbh/TBJfyQ5Fnx+mS8TUhenbwO6AuU3k6e20N3HDdQnRvmJ4Lp+iTkxdzx33n4XTAoQK
	JPkRWX8/JA1RTK65VgTxSJINe1GY=
X-Google-Smtp-Source: AGHT+IF2CLANwPXgLOi/X3xdcF7eqcbH5HVbLixjLw35MdESIxI+1bSKmxLi9TRbe6Tw/K5G0zeNt2YE+cGGJ3tSJJ0=
X-Received: by 2002:a17:90a:68cc:b0:2c9:7e9c:9637 with SMTP id
 98e67ed59e1d1-2d1e7fbf50cmr3437763a91.13.1723241414350; Fri, 09 Aug 2024
 15:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134346.10630-1-zehuixu@whu.edu.cn>
In-Reply-To: <20240731134346.10630-1-zehuixu@whu.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Aug 2024 00:10:02 +0200
Message-ID: <CANiq72=mo1ujT11Rai+9J1G3a4OUTzQAx307=WF+h0t2=m7qeg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Zehui Xu <zehuixu@whu.edu.cn>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:45=E2=80=AFPM Zehui Xu <zehuixu@whu.edu.cn> wrote=
:
>
> GCC 14 recently added -fmin-function-alignment option and the
> root Makefile uses it to replace -falign-functions when available.
> However, this flag can cause issues when passed to the Rust
> Makefile and affect the bindgen process. Bindgen relies on
> libclang to parse C code, and currently does not support the
> -fmin-function-alignment flag, leading to compilation failures
> when GCC 14 is used.
>
> This patch addresses the issue by adding -fmin-function-alignment
> to the bindgen_skip_c_flags in rust/Makefile. This prevents the
> flag from causing compilation issues.
>
> Link: https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pa=
vlu@suse.com/
> Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>

Applied to `rust-fixes` -- thanks everyone!

    [ Matthew and Gary confirm function alignment should not change
      the ABI in a way that bindgen would care about, thus we did
      not need the extra logic for bindgen from v2. - Miguel ]

    [ Reworded title. - Miguel ]

Cheers,
Miguel

