Return-Path: <linux-kernel+bounces-390380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486E9B791E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EA61F25687
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B37199FCD;
	Thu, 31 Oct 2024 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mslcOktV"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF714659B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372077; cv=none; b=jN2OIO1+lStXZw5KYtpNlmqHxP29INJSZ577xEElHTOJsEzwxarVwrZ9ZH7n4h2RsbZ+fxbwfbV+K8x4HiJS524G4JKnuHH8dWcP8Dylu9MqL1w/sq3FOgjZuo4JkOQ9y+hHM1ilbMIf8RJaOFJ1QnnMcitEQ2B7ZhjEtAuojOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372077; c=relaxed/simple;
	bh=eJU7ft0G0wwCMJUvfDgJx/mJhmEN5+P44V57HfkTVCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q20YiwB2UY54iJHjfEYUZF0Q6VvGJ+b0VUFti4is0GRaqYaCY/e69mTzVLSV14lT7FJMvOZi2FyUung1D42Xq28Mf21zLHEundxLLVBt4dPVwd7H/vcrG7O09Lc8xWarymI7d7pnGtTbCCPU+ZWTuci97HMfczrfij1eUskigN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mslcOktV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d5aedd177so596323f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730372073; x=1730976873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJU7ft0G0wwCMJUvfDgJx/mJhmEN5+P44V57HfkTVCw=;
        b=mslcOktVpbmqiwG2tbWZrRaS1ja8YkkKK+1ohx1sXNgQegNpKLNjMjEdyhCrxmjd+M
         l65Te+Vk4SCzIILT1KiA6b845z/51LGa0K1M4jlDb9PyA48ZJYGES6ionmMbTjDa2xA0
         62CM8n064go1uUQwaOVBY8wRZ/CXnnfsnACpnFXtBNPcIe97tzbZkm9m4xZAX2ZzM9xo
         /yJoK+ZbpA7ryCvgDPWxG0YLfkW7/XC4rbgEuonbqLBXoX0VZwUohdWZKSFP4KaW+zMj
         IZYLVkAMpv4+zCgW6n91htWH4vQbZCLxE0rj4pDcI08LRgWrvs1ovUmaUfALKh8e24Q6
         2juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372073; x=1730976873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJU7ft0G0wwCMJUvfDgJx/mJhmEN5+P44V57HfkTVCw=;
        b=eh11ckBZhrCOk1N7qGSsTD2NZjTDRZ7LxtdUcLZHggZCZY4xQ025bIWlUydHxcNVXq
         jAPwjg1grg/mtpeEbrHbt04EOT3vRu0M6fhflH2DT7HRvWR2RIJ0MaqURuYYEZYyqTVD
         iGzJNz7R1x03edmoyNoKl5Npb98ugsXmVVgGHkCMpXKe27Qx2EOnVu06R5CGr2c0r1d0
         j7Y9u5cGHQyi4YH3cBI7+aj51ICA93ol6qG6zzJ1h7kk2H5krph+UpV5M73T1kBLwRWs
         UugQty2NdOLD4JTSapUWVgOF5wkcKzXjxvU1HZiUIBusDgcd01THo/YnlleVnNPTgqkR
         kPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsMuy8UNBxrNenNThVBxlyrSwJVTMwK9QBAgYlRc2vrPXExjgb6rc1VezGkuqosNz1JdQqUjgXEccEoYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDf/h1zs8qvEjZkCzzgojK1FZ7n9me8g+cha7sutvXF3i0yTw3
	1z5GyzS2rJws94dkq+7qJtHR8l9TrDKri+ExUzy5uh2krIBiYqfi73nvQvT+joQQbJV32sjmsdS
	bTjsCtF6V32nrgtnrJeMXO4D2kAI2XUC2BeOF
X-Google-Smtp-Source: AGHT+IFzEtsHHvmMUx5AWnEjByPnzA0sP8w38muFmRKQcoP0pvNMw7j0rk0hLEMLGCtkMs8DMzdIVVFpvOzJisqe8vI=
X-Received: by 2002:a05:6000:1f8e:b0:37d:4f1b:361 with SMTP id
 ffacd0b85a97d-381be79baf3mr2094286f8f.25.1730372073314; Thu, 31 Oct 2024
 03:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com> <20241030-borrow-mut-v1-5-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-5-8f0ceaf78eaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 31 Oct 2024 11:54:20 +0100
Message-ID: <CAH5fLggeAm1qobKzUkjw-+oNQRnCaDH2f2TTiRvmrRMg417LCA@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:46=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> From: Alice Ryhl <aliceryhl@google.com>
>
> Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
> that was intended to provide mutable access to the inner value. However,
> the method accidentally made it possible to change the address of the
> object being modified, which usually isn't what we want. (And when we
> want that, it can be done by calling `from_foreign` and `into_foreign`,
> like how the old `borrow_mut` was implemented.)
>
> In this patch, we introduce an alternate definition of `borrow_mut` that
> solves the previous problem. Conceptually, given a pointer type `P` that
> implements `ForeignOwnable`, the `borrow_mut` method gives you the same
> kind of access as an `&mut P` would, except that it does not let you
> change the pointer `P` itself.
>
> This is analogous to how the existing `borrow` method provides the same
> kind of access to the inner value as an `&P`.
>
> Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
> immutable access to the inner `T`. This is because mutable references
> assume exclusive access, but there might be other handles to the same
> reference counted value, so the access isn't exclusive. The `Arc` type
> implements this by making `borrow_mut` return the same type as `borrow`.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

You must add your own SoB at the end when resending other's patches.

Alice

