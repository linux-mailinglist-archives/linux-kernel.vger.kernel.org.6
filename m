Return-Path: <linux-kernel+bounces-420671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B92D9D81F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80291162696
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048D19007D;
	Mon, 25 Nov 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rddv+XPM"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CE190055
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526064; cv=none; b=NTZZKF0zKOWgyjuzOLU464N7wQBGx1VLM2g2ATF9KAcPtEBNzwm2LSMXAf2+U2tlxiHEMgeoNYc+aBe98nFZLU6bZQNw1NWvcZBmYAj82c/P/XGHw4rTHLFuV4y66ARhlwIYhfOUfYT1rYY6Y2gURSuwzMfBtZ5iPzQKvJ82owY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526064; c=relaxed/simple;
	bh=uSsPtNnVteIM2BzthXpkxL9YoGLmPqhmZKg37rTE7Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJGweuG9PV5rpcSQol3/W7PUL0Sp2NDwSdP21dxV9H+qCJ3A1vsYFgU4lCsGOZgi49e4CN50L5C7qnlMGZo0uQzYb7fiEwgh2MuvHUdA1smq9T76E5Gq1j533xDmhKlj6vnd1NsMHhCscvK4W3I24Zv5/lfvnkAmhCdzlfqVjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rddv+XPM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382456c6597so3011224f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732526061; x=1733130861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrdMiDJt5vduIxa0PY5GoA+617/ZMEzbh2yCH7ixs2Q=;
        b=rddv+XPMAIXrLkGAPOpX+Lxk/dHpmmSxHz+copGp430O29dLB3W1ClZdOX+PFwLS//
         83AS6KyGKm80EEsweut4Hrt31pFzll/QEVyrT/2MXtevBUUhLol+Sa+TM7CLxorntGe/
         GvY/4a9NlXFbw1y1DoxxSMKIPiKBp1l5PjZGcJH3krTV7wfnD/gJ6AoMbQUxUb3I4NAR
         DQ57y1qXaoISH4PPTihcIm4sbfQdzYYL7PUJUIRF531mWo0SAnJ74Jsm415Ge+MxLKST
         KvqXJkrkEupqKZSCSh2vHNPiuLVlNd2SIXcVgmReAXtwv8N7r0+EaBe1adauWWHXXXix
         ghfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526061; x=1733130861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrdMiDJt5vduIxa0PY5GoA+617/ZMEzbh2yCH7ixs2Q=;
        b=BMeubsUyloYmrOy8cXRTf1+f60KilSQv0LvV5QZCnqwZ5rptIuJnlyVu9eJquWNjiF
         jBxsepLSiZm1fJrBUTPQXnLaUcQ6qaOtMfeNWA5H98ds8DGsLFnmwxn1YEXoEjKROQFR
         bpAjitjL18fJmt/gLfdtKvjYfeneGHs1fNIQl9TAlHNYR/5NaM4ieluL7JgNggzfHqLX
         +ltZLUBP37tF0Gqh0Ld5id9XpuTwsE3bWCRJ5WGFRZmpDprakq00VdV744ScO81G5oLi
         7n01q89AmY+OzU2+u94CmGKylnW/82RbmyeNxmVM2oxHUF8oUmvchW0KSct0EJTK+Ak6
         xFxg==
X-Forwarded-Encrypted: i=1; AJvYcCV0VnnAEWm4SZF9hbNN9j5DPO7p8sZ8LBEpiyMWl0V/RsUTOWSxK4XFkx0DRy2ezPY1FywYPJTKbUTTw7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzbXG14wSMggLjppRM29QmiqMPuj/fSGUXa1A17/Fnu008azv
	UKVT/+RZ39TkfHmbg2l0D0T6VlPP4xAaSiZdjeXKYSQaS5ttdgooIFV/IhK9KxmkejHe8Vaint6
	jRzWGuHb2Xpi8O7oFn+onZ0skBbCH3oo7G8gj
X-Gm-Gg: ASbGncsO0X6M56I0dkTYQUJydOaPZ44MLZysSSeHFrBjYCMIvnO9fNgsOdXT9CkvgsK
	5lJiVnhSxzv8NiqfrDhhuirUnant2giO23Y3EWqkngBVMh7NJvMz1hbKKuNz/Xg==
X-Google-Smtp-Source: AGHT+IEOwMk3vapdbNHpELN0oZ6s3oro3YnZRn8GCOYxBikHFeMCXOFfPD4cUTzyUloMpcTHt84sQUv4Gf+wLfw8W4o=
X-Received: by 2002:a05:6000:23c5:b0:382:3e51:4b1d with SMTP id
 ffacd0b85a97d-38260b59530mr6868816f8f.20.1732526061276; Mon, 25 Nov 2024
 01:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org> <20241123222849.350287-2-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-2-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:14:09 +0100
Message-ID: <CAH5fLggK_uL0izyDogqdxqp+UEiDbMW555zgS6jk=gw3n07f6A@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: kernel: move `build_error` hidden function to
 prevent mistakes
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:29=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Users were using the hidden exported `kernel::build_error` function
> instead of the intended `kernel::build_error!` macro, e.g. see the
> previous commit.
>
> To force to use the macro, move it into the `build_assert` module,
> thus making it a compilation error and avoiding a collision in the same
> "namespace". Using the function now would require typing the module name
> (which is hidden), not just a single character.
>
> Now attempting to use the function will trigger this error with the
> right suggestion by the compiler:
>
>       error[E0423]: expected function, found macro `kernel::build_error`
>       --> samples/rust/rust_minimal.rs:29:9
>          |
>       29 |         kernel::build_error();
>          |         ^^^^^^^^^^^^^^^^^^^ not a function
>          |
>       help: use `!` to invoke the macro
>          |
>       29 |         kernel::build_error!();
>          |                            +
>
> An alternative would be using an alias, but it would be more complex
> and moving it into the module seems right since it belongs there and
> reduces the amount of code at the crate root.
>
> Keep the `#[doc(hidden)]` inside `build_assert` in case the module is
> not hidden in the future.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index bf8d7f841f94..73e33a41ea04 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -32,7 +32,8 @@
>  pub mod alloc;
>  #[cfg(CONFIG_BLOCK)]
>  pub mod block;
> -mod build_assert;
> +#[doc(hidden)]
> +pub mod build_assert;

You could also put #![doc(hidden)] at the top of build_assert.rs to
simplify the lib.rs list. Not sure what is best.

Alice

