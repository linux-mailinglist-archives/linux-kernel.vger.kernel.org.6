Return-Path: <linux-kernel+bounces-291227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC8955F57
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02BF1C20CEF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212591553AF;
	Sun, 18 Aug 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcQBMDFo"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F5154C14;
	Sun, 18 Aug 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724016760; cv=none; b=d/1E2mIcpKIJussDmsLQFweD5VdS05AqJNEH0Z89ENMFAnbJGzkqjQk0wcpHRAP10VJKCWXHP/OCMZaH5lOIiWFihEgZqR3KNt/1CApPh4O/gFgX8h7d4tiwhVn1UmIDqnZOK1PNdxW7ZKQ005cDe9heBzU7sGON2E85vcACbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724016760; c=relaxed/simple;
	bh=ho8VnqsEKFFMaGaEZKuaqkFuYWqoFAgEJWsjstMltkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvo0OyajJEp/v6AU/2XN5TPJnwyHskldjbHST/9PedXcu/37x1S8A7hFzSiYAdk+M80Lh/oaZ6w4R7C/C7wu1IS+9AfqUXvgWx+Kwy5Uh23r7xEGoydgeUnIKNR/I3Ew4WD8qZ0XJbBPpRkAt59Yf9dIVAVglEstQAIDw64jBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcQBMDFo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso2908410b3a.2;
        Sun, 18 Aug 2024 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724016758; x=1724621558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ull0aFVTCH5dHxXF31R/BROXCPVceforOFPiRwZ1/6Q=;
        b=KcQBMDFok8ht+jIMnbuGPMak75aktHq06MyrsupgMjWwS04VS2n7zJiVe9BYWgvidj
         jgshvtkmbhlYZnxzb3HuSzNIXFfpbF8ZlyKgnpvvXF7bn+h8rEXVjTBF/9J8+WcnHM7T
         9PkEBRoxLFAUB3VLQo2OBE5bl/+ehvGxpwLOtjy6wZbVas9Io2JjHBEoHsdWMCiRXRvc
         p1Lir6Qx/YFu3k+cUYIDfiWYUXBYgkPWwzBrlq3WxG3pVJ3k2oMiwqO6hgOBylSFdRA4
         aHqWcsHmg/36iXoPJWayHsCWsgOen9osfoxjNqh/FAag2GGlV3t6QbC0yT9BjJzr5XFA
         DOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724016758; x=1724621558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ull0aFVTCH5dHxXF31R/BROXCPVceforOFPiRwZ1/6Q=;
        b=kE9ZCILFEW2c0+Qe1DrHTX3OLJHrlZ5dxMJBZFfa3ncMsnGSSuYVFGQ3/3TedQA/hi
         2i9cvuKOFEjzMlq425thSpKiqJSUyAH566tKA1e5/K8gZPPQz3bsTUNyeWm0+dQvG2d2
         NKs0RAtrjgqZK89Bg1/HzeiwaSAO6fNZyu+T3XRnmY03wpye6wUWBc4IuvXMCG5b+vbh
         eaqphp2op/zSTqqRhWN1gOsZgQCLFLelOGkMh+n4FTkWjfA03T3ZKkHgLZoWza1N/z0f
         BlKqTF9f1r1xLAwrd5x7gafzo1Y2BEsmXHYpvuftoHw9n6tXHetWQypGyMqDTx1lzQ4e
         wcFg==
X-Forwarded-Encrypted: i=1; AJvYcCVqy3hLqGkBxdLWrhHSzn8/owS07wIlt/imSlaN4OYVh8H1XhdJC5zHRIKykcXrOX7sWNW+BNGQ83cS7tP0YxXoNrUIpaN2F2jSHlmkJhAIptRZRlRZuySMFHr8QFZbA8yd+C2FaUEWydkXKnE=
X-Gm-Message-State: AOJu0YyfwXxu0Iac6xq0SeQKiVc0u+sQFjY5oJSh54izERwBVVOIL4Eq
	qeSBQCgkwuleCnMS1EoLyzTUYEWLja1pdQqGzQlyeGuB/0dv4xeb9fMvmQsesIt1IFlG2IHI/Lv
	p8ij6gB8/VwPGpQlYye4k/hfWe28=
X-Google-Smtp-Source: AGHT+IHd/SqDxbdpvK1IHyEAwLl44igeud2eE+bt8dWF8L/Cox5wyEBZnoJMM5JjApFdL43RFd7xuW9iAI/uLKH2p3A=
X-Received: by 2002:a05:6a20:d04d:b0:1c6:af37:edfc with SMTP id
 adf61e73a8af0-1caa371ba2fmr6789334637.49.1724016758315; Sun, 18 Aug 2024
 14:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730155702.1110144-1-ojeda@kernel.org>
In-Reply-To: <20240730155702.1110144-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Aug 2024 23:32:26 +0200
Message-ID: <CANiq72=62mXHyurwDkqvesVFy0FSW24o7hx=BJvY3X8p+H39Ag@mail.gmail.com>
Subject: Re: [PATCH] rust: error: allow `useless_conversion` for 32-bit builds
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sven Van Asbroeck <thesven73@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:57=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> For the new Rust support for 32-bit arm [1], Clippy warns:
>
>     error: useless conversion to the same type: `i32`
>        --> rust/kernel/error.rs:139:36
>         |
>     139 |         unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
>         |                                    ^^^^^^^^^^^^^ help: consider=
 removing `.into()`: `self.0`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#useless_conversion
>         =3D note: `-D clippy::useless-conversion` implied by `-D warnings=
`
>         =3D help: to override `-D warnings` add `#[allow(clippy::useless_=
conversion)]`
>
> The `self.0.into()` converts an `c_int` into `ERR_PTR`'s parameter
> which is a `c_long`. Thus, both types are `i32` in 32-bit. Therefore,
> allow it for those architectures.
>
> Link: https://lore.kernel.org/rust-for-linux/2dbd1491-149d-443c-9802-7578=
6a6a3b73@gmail.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

    [ Fixed typo in tag. - Miguel ]

We can also change the formatting later on top of the series that will
enable that lint.

Cheers,
Miguel

