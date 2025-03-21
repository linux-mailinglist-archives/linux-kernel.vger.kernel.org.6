Return-Path: <linux-kernel+bounces-570816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA05A6B4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FC03B9D41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C31EDA0A;
	Fri, 21 Mar 2025 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKkRALy1"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDC1EB1BC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541890; cv=none; b=teIV6lJT+lqCzl+d1gJuI/d0JAbPE4BJjiVahDomewfy2TcRFW8oMIR5H6hXbUgJbAV+BK5g6We7qoNYx7Fzp13BE2LMTUvJ728bBfD0au+G+6BDVY8YJ1Jm6vRJY18Vi73fx+nu+V3iNtZuEAKjkdcecDxymP4gAnHYG9+13yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541890; c=relaxed/simple;
	bh=GvJbJb2k4SXkI+DB6xb7jXn1dzz1f7dnJ0eYK2KNtKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6qFTA9xRolvGSN8cDl80TLhF5OL17IawokbMz9ZNLQ4bz2yRVQ/zseWVonzTsR4pXmSgVL4D76Ae13Tk7g240hjSsaYQVYj7xEnP/c7I6lyWdaEX+VOC450WcDGYqJWDTOBxCIdThiLF2aqqdknHWAOCfCYf9F0rauywDgvHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sKkRALy1; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso1917653e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742541887; x=1743146687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVyfGUOFUSHLpd+RTbyaNMFA8E3JrIjaFBTf+PEcZSM=;
        b=sKkRALy1cans+zlKXhw3YjjDhJJ2xDeoyU46k7AYA+/wShZEwBxI51J452sF3wJ6M2
         y9TZb/rgplviMyWcCfAOVidjS/9RyiAqSXD6rPoNioEEMsBRZSSPwlAq2C/jQvWChukV
         0lh9O9NJx2AR+YbDP2ToZe1fqQk9eoMtN2bnA8BA/g1u8pJ2BFJyKRkgFGAp9MuNyCEJ
         e3PHHgLGnVWAVxiwsWSpt8i11jRKJpflbCqSQVoytGcCHuyDFGKnFDNtidp5sVXYBhYZ
         k1+gBe5RnSLDnllfu5KAKw7YjETMnKEGXhjCnBXTnSqk+/uaiQSO3EpmY2ovumFZb4iS
         VWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742541887; x=1743146687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVyfGUOFUSHLpd+RTbyaNMFA8E3JrIjaFBTf+PEcZSM=;
        b=RtB2eG9rdF3zQTsOrHTR/KiQ2xJQNJU2G57xsNyKGKy92KpjHLZiO3VeKQsGLA9nhS
         72sh4sYd5UYlUW+HRK5JCRhFOGCAdXvWJtTnh7RZ2RseQb6H9/XAa+PIyrQkop8rXv50
         1w3Foo3ImeHvhex+1hl1a4gIykXn36e22FOQyQuTx5ggj8DcfEkG8m1rvKgEWo9UZLQe
         8iEEkJL8oDEzgJybX3Ex6bH084eM5F9TDlXyRQR51NRmaaR+BJAavWyYel/AQmnwkQx8
         N7RvA5L+XtIb7MUlk71rocuTpbKBbnsDHiKmCppW/PfCsyQDfYvOHJX13hemu/I2Oy50
         ZA7w==
X-Forwarded-Encrypted: i=1; AJvYcCW6hRiPh97Zqf/kA5qUg7Rpyhw6mY5AijTljV2AC0CgAruS2L97DPXkdvtmUZZfYPCKtVeAApAaXBQFBnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBX8hX4iZHtHx2eWQKJfgcCsd2F9U/9U205+Xyww+rpNPCOF7F
	X3E7mwA+KDAaosbciukX1OoQib54MN1jjIUzjL0ARrEEAbhefO4GpNjN0ajlNw/X4IzJ78MwKI6
	g44qw1CurqP64bHnX8kfJlqY07QRYTJvJ+SC+1Q==
X-Gm-Gg: ASbGncu2c5L6mTxynP3accpuHg6d+Uaj1Lae0OITCL3VKHeaSfwab7/YpAmXdTYmqib
	+EgrynPx/EB79DhZvpM4VAEDcY3fq/MsZvIOLnaWgGB4iOOskkBio22Wst9p4qyQB7KLmsPFFKa
	id3DiwIZfwi/68VFQfOQyRj2U=
X-Google-Smtp-Source: AGHT+IEWRekqmOvhJIkrtmfcrr34V+9XLm1jjexqdrUw/nqwY2LEQjDKYJw0o/Gv3K8ftncPtiQfEPoemo3Nbl/AyTw=
X-Received: by 2002:ac2:4c46:0:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-54ad64f8ca1mr798251e87.46.1742541886976; Fri, 21 Mar 2025
 00:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-rfl-arm32-v3-1-8f13623d42c5@gmail.com>
In-Reply-To: <20250123-rfl-arm32-v3-1-8f13623d42c5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Mar 2025 08:24:36 +0100
X-Gm-Features: AQ5f1JpxlbDrVh2n-nCT0EYt0uyc34jntnze-kB14guAoH3gv0enUrmOfcimymE
Message-ID: <CACRpkdYF0sVB2-qgy=GzETSR3+2sagVQPGdunDQDJrn8KqJorA@mail.gmail.com>
Subject: Re: [PATCH v3] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Rudraksha Gupta <guptarud@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sven Van Asbroeck <thesven73@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

thanks for your patch!

Sorry for being late to the show. I missed this very nice patch
that was actually on my personal TODO but I have to much
to do and also I'm not smart with Rust, but I'm a big supporter.

On Thu, Jan 23, 2025 at 11:40=E2=80=AFPM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:

> +       select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7

Nothing in the patch series really explains this restriction, so it
should be in the commit message. Arnd mentions some atomics
etc, but we really need to know exactly why this is in the patch.

I'm a bit surprised by this since the rustc LLVM backend nowadays
support all old ARM ISAs. I would have expected:

select HAVE_RUST if AEABI

Ideally this should work on any ARM core, but it's fair to require
EABI.

The big reason: I think we want to be able to use Rust in kernel
core components sooner than ARMv5 goes away from the kernel.

If testing is the only issue, I can provide testing on ARMv4, v5,
ARMv5 BE etc, just tell me how to test. (But I guess it's more than
that...)

Yours,
Linus Walleij

