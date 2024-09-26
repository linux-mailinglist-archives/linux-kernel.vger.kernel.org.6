Return-Path: <linux-kernel+bounces-341038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8DE987A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228DD1C21F09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF918801A;
	Thu, 26 Sep 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFSV61e/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC518800D;
	Thu, 26 Sep 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385555; cv=none; b=o+0pfJ6ansfcf2QjyqQrevvEMNp5k9NT1vY8lhFzibFYvwUobC+w60aj1i7IGehKtUUo8S0jeTviU/uyLr+qG6MfEX45HhclzgpFhb6fMyE08naP2nw3YLCQoViOgO0KI73Q1NF97X4CoXn3Ns6BT99ncjdPIwj5CmqEhUa4eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385555; c=relaxed/simple;
	bh=YEKHoo43BF79Gz23kSQAk8+dmLPPoq5zevMJhdfoyBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaCT/7XyKnOMExN1odW21luv8JM7yd0+81CSrXfMStVJV/JO7rkxe/JfXQiv/jARrq36x0HGy30wlY6+y5bHTsrJDDQOeSBJ+KIyCZQIoG3VijFtU4333m63ZPTfMCHsLZgkiHY8UvQAlPa38+hWnOJclCytevwkOQKu+7Y8bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFSV61e/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7191f1875d3so186132b3a.0;
        Thu, 26 Sep 2024 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727385553; x=1727990353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEKHoo43BF79Gz23kSQAk8+dmLPPoq5zevMJhdfoyBE=;
        b=bFSV61e/gDKqsybBBvT6RaulbvIKrgZJYCFOAvwSdaH+zSOGBz1SfnCP1xWvBEiY+B
         jwZ61i2mrqpWDG2k+bOTqRURdDiJWBJNpy7leOyqTHTmxgNln9sHjBRSbjY9W4zU9M6A
         aCuIQEsss1vzDIYxFpuyT6LbkSz0VuOh+pl/eVEEIBoR1iCqeuFzB+gyyrmHC6GR/o0w
         F2Rh2RdYU5ufOSfVAtpKA0d3lI0vyx2d2Ji+3kpWy1bpC5Lv6moTGIE5UcUClzHuVHrZ
         i40lGy6mL19a6HH/hu0BWqR4Xmt9G4U4mGqRJnRN0e3kv2NVLZU+FGTgBSB2rUIcVTc8
         QXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727385553; x=1727990353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEKHoo43BF79Gz23kSQAk8+dmLPPoq5zevMJhdfoyBE=;
        b=HuCpDzPX0mhcGzxyPdR47dYkW//jmsSU84dTNIWEXLWcM3PzVvdsZXC2p1JAG2HyvZ
         Afiyci/lLPE6XVNouOwNEwxdnllP52amg4CJxQNJyKGX2JYpwKjV7awTsNBdSpEk5Mgc
         kDrf0e4YPque4GC8rxIesyp19E17pIqejA7+3VXzpndTIS+ZQoofkDJaVaEfeFG8wZ4V
         6/Cyypit8a19NC1ZLGB9Wrdp6b2tlFlgHmisxIrDDGFqDIQGUrF+gkkm+s0b/OMhaHdd
         sv4I9K948d0tBKW8ShmMPM6ISErv61bRKct5Sk20A25Jl9KKtZcgORKVNwT49Mkw9Qik
         7BZw==
X-Forwarded-Encrypted: i=1; AJvYcCUsexJ8EEDVjwcYEL+ddqvlGV+paitQSIwgVfkLslD994JfkeTG6VMLGNbecxKT6iqxUioGvFhQUYUaMCE=@vger.kernel.org, AJvYcCXfbgtVCuPUx4SN2Ul1/7l5NJ+ytyhOmFea+4sYcx+WWyqHlTG+aKB4UX2gGXz/TFQyiEiQcfNJqeaCO0hbs3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzts3wSWPbOpxpqvD3Fv0Uk2YkqzObVO4eyaCcPusvNN2U/abA
	2t6ku2l0GdLDl4RjtAW9q3AoxZn3dz8JJx5bsYsqXQG+E2STYVTLIfnrw1OnKtvRy5CLKkMwHoV
	GbyT0lQc3TkLZ6UmyW5pJ2g+EMYk=
X-Google-Smtp-Source: AGHT+IHULP3pU3vUe/QzsEsWGXZyg5HaYhsoOAbzA5msEXfvnbs+cNXkKhwNX7aRIH724eXaazA1vELV1IzArwEqRhI=
X-Received: by 2002:a05:6a00:1407:b0:70d:2c09:45ff with SMTP id
 d2e1a72fcca58-71b2604d429mr749238b3a.4.1727385553106; Thu, 26 Sep 2024
 14:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925141944.277936-1-ojeda@kernel.org>
In-Reply-To: <20240925141944.277936-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:18:59 +0200
Message-ID: <CANiq72meNkvahLDAxPUq4suzFY_xUgxEW6vGsWuo9ZzeiNrQJA@mail.gmail.com>
Subject: Re: [PATCH] rust: cfi: fix `patchable-function-entry` starting version
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:20=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The `-Zpatchable-function-entry` flag is available since Rust
> 1.81.0, not Rust 1.80.0, i.e. commit ac7595fdb1ee ("Support for -Z
> patchable-function-entry") in upstream Rust.
>
> Fixes: ca627e636551 ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

