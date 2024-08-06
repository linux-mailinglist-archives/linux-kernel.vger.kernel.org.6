Return-Path: <linux-kernel+bounces-276906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD779499EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3863AB22C8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B616BE27;
	Tue,  6 Aug 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLbaiJu2"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD515ECED;
	Tue,  6 Aug 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978895; cv=none; b=PENvHXyx7GEOnBdiJqdZT1pw2RiQWkKrWy6+HOBCKTvwuueMe4k+QIC5/YiLxeOP6fiyRenZMkyPCP5Xl7YVIGn9W1qwly7LaHdUik15CM9ap9fzxIp1MWLN3PQUsMr7Tx/66IxwknorOQe1ALRrpyem4W5Zi3hwy2NS5nBfi3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978895; c=relaxed/simple;
	bh=/rh41jvzIxJEsvibJ0CSaL6FFeVsrsO1w8EFTwMPrzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGXKcwViFKxSEAOvoUHFbIR5ZpIBfxHzM2NdO4xQZnSVaVk/fK9ZkvFSetdd7fK6WcS1nKESRbNgZnB+gixcd+BjEhLq6VIjuZC23dTx0xUpsb5woT/ACH5GXteFj4EQbfhBRFUdEkp8HY3Yb4QgGeUwEwkwQK3iqB0e9ZDA7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLbaiJu2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so939723a91.2;
        Tue, 06 Aug 2024 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722978893; x=1723583693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rh41jvzIxJEsvibJ0CSaL6FFeVsrsO1w8EFTwMPrzo=;
        b=CLbaiJu2ar/hN5+YtIvMhy4HQHdU3MsPLToq2nJAkOyXnPpV6nOVFLLnTTjaDN99qQ
         MfF/zbIzBHlAW14KAXbAzdZT6W8iv0k5if1sNOO3i8KVDfQBdrlc+8xEKx8hVYEZ5Enq
         qVFIuj4S0pnZyd0PVUySLiT41eBjo43SFfuQKCIdXjYu7Iebivipm90ua2f/zhcUpZVA
         dmgZL9jdHeG+rfPSQ0qi/PVQ9rOzhR7YAH7l20QckkDgv1hMctD/YYaP/nSDpqXDfq3E
         8VJzzspgoFTfQPgJDikn0cm62lDGLXAdkRShRSZ5Kf7d2G+eWSBjm4O5Iwpvs3DQ/ToZ
         0uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722978893; x=1723583693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rh41jvzIxJEsvibJ0CSaL6FFeVsrsO1w8EFTwMPrzo=;
        b=sn22NcYGCp3DMtNemIYuSktzjqs9xrU9Na5mHO6l1QmwYkYVxY2jXeNF6zuBXdBUqC
         h+58IIlcrTk2HQmvAXpYDBEwIJsdlmcZ8ojnElUR2bAl682uXxk5wt3YjuZk7xQLDR2U
         kLDBYadcvw5vYoImhm9daIuh31sBXo8YdzWwaY68/o3GnXBspE/X7euMRfmeh04m3tL7
         MG0uDky8ZZo1YwWNlVfSEA4df97ybCceaaQFYPJCu40ZD0IzceLWN85KZQffMfkEzkqk
         27H4A4BX7Im46tvEdwgWDCFHZA7d+AFUXv0bDYI/BIDOIk2D9UoKa083VSJZHSjCM6GK
         ejlw==
X-Forwarded-Encrypted: i=1; AJvYcCWY+b7tYzasoDMvk1R6c2LqX4KT0Kk1x+fL4DR0zV3RL7pK3KnoYQ9MDdospGUcdyn929r6JBlOORGqp7/4xkG42+O4KpQWKEhkT2aDJbI1ujgIHz9BjgVUskE6Yrpriat4j9lGPzhogpqucc8=
X-Gm-Message-State: AOJu0YyiFWgziDXqFZMPas82kbOM8WvH3IcgGIl2CSP4wO1dnuP4cnZL
	QCGR92/8qc9jxCmTO+DNTDMBimdenvKQqlP5RC4NTpizdaQre2een9KIXDfZ3TVVTor5rfGp5he
	No2zLL5/IeAsGy6525ayAlURQZQ4/pd7BB58=
X-Google-Smtp-Source: AGHT+IGlaEX4zBGAQOzFZ8UxWiEhKKhxKoVQfNV94CY7VWHsWQgedWZMs370He/eyDvIZ8GBiiPKDdFJ3y5qLobFQko=
X-Received: by 2002:a17:90b:3b8a:b0:2c9:5c63:29f4 with SMTP id
 98e67ed59e1d1-2cff9469450mr19399363a91.25.1722978892680; Tue, 06 Aug 2024
 14:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806150619.192882-1-ojeda@kernel.org> <CALNs47swnK6je1o+LOLUFCDEZJmQmZx8vZ+7MPvUbNKdFr_Q_Q@mail.gmail.com>
In-Reply-To: <CALNs47swnK6je1o+LOLUFCDEZJmQmZx8vZ+7MPvUbNKdFr_Q_Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 23:14:40 +0200
Message-ID: <CANiq72mRCOq2xfhNMFg8VNBv9+KqoFp9hd6xe06zb9uyH+YfJg@mail.gmail.com>
Subject: Re: [PATCH] rust: add intrinsics to fix `-Os` builds
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:30=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wro=
te:
>
> Should this link have the `[1]`?

Yeah, good eyes :)

> Reviewed-by: Trevor Gross <tmgross@umich.edu>
>
> Also submitted a fix upstream https://github.com/rust-lang/rust/pull/1287=
49.

Thanks a lot! Linked in the `core` sublist in issue #2.

Cheers,
Miguel

