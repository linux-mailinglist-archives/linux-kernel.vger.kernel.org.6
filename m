Return-Path: <linux-kernel+bounces-287637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBA952A38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D661F21899
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2363D198E71;
	Thu, 15 Aug 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DY3lNqIM"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA717625A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708625; cv=none; b=MmuGpwFhJf3ZXJpNF8pT81tECfvfRpP/X8+Ot0RE765SB2KWJnjxunyIWoDGARIRzZwDKER+bVxMlDVJBea4UmO5hyCaeh5zmYMT/WoHNgf2emPEGB61Z5+o9RTVXDi3CzeVZDfzJcSUKvKZy9ePK8KB/8xKnSIL+hyNfUTgG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708625; c=relaxed/simple;
	bh=lFaxAIKnjHKxlZBdeFXofarPjUb1JU4bQlq7BQ4PqII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0sB8JhUcK2iMs28ALFgeXlZoQsCduqE3O0n+Ni9tWLmHIcp8uz6I7cooL2nOdH+5RUC7Kh+gwWgHJAMD+29XOX0pEa2eY7dFsiVOHrLQN5EdTsnVOKS+ZwPIArgRzjfo2vsJa4qBBAWo6zCpnHSDoTq9bhlX8r/aw69i+/ZOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DY3lNqIM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso5547055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723708622; x=1724313422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFDgfr18jKgjWjTVFgaR01eg1gTio0cJGxh6b91x9kI=;
        b=DY3lNqIM1qtQ7LniAOIidz9AC316Y3uGEW7SxbGvMUOelPaDtAt4SGCbH90KjxD3Pi
         QkOnDqJYNvAsiGop1cVA+5B/HLOUaMPfYhRbFcMze7LNQkFxh4CZvyGFuJsVGgHWG7Q9
         RR73e3gCUaROUnt+rnMyEwI7iduRtj2QymfZeCHu79KWzvZV/H8/wpoCiK+H98Y2dJSb
         KUntjiXoI/FRrJqnUZhT0Sc82OiQcVxTlbIm7xbg7c0QlGyt8MWep0FXHCbY5S+MRpMs
         Z8xjOeOAwRWKI9Ru8ABtBgvjzP2uj8jFpLixzsxDe3y1HGkMNb353OWeFvtNfQsd3WLj
         yGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723708622; x=1724313422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFDgfr18jKgjWjTVFgaR01eg1gTio0cJGxh6b91x9kI=;
        b=dR4AcolfP70SezSzDZJZnT/IaoZKls915yPMwC3YIQfz/TXq7fTUfKFHO9NkW2ttZz
         Cqd3wk6qwDJv5/zr5rGdaozTENHcfLFDik/CIHQaTbaSkBZsB1v+1eP6lSxU/7j+5mUN
         FtK6QJCR9yKSqOPux6zUeV3/fnZObtBnNC7cUp7oHUk15nQaRjgqH24Ngv138OB8Acrp
         YEM9TgWlz4sARhIp7uig9AD/8IPqZSmnHdp1aYoS0FY6QScE9T3ZWH19PfUWvii3CikO
         gb1wdFdQ5XUgaqg4njuo/30Pop1Lpjtbcu+TanWY0mi5S6g4/z1EaT9J+Y93wXpTscjG
         v9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6El5OXiFS6W61OHSA3p4FMSRbE/FrhHCn45TCN/UgY84bv/ZK+bRuLJD8t39u3gw3hnjTWEydb4NuGEJWCWFslKPyi/HwCAhQlS4B
X-Gm-Message-State: AOJu0YxjqT7srov6DlGqvGqrieg7iF3cCGMQ4dB/VAVBlPFq6UrzpQfs
	fqMu3KnnKSb5bDDGmrkVx2QelROMw57Y7RMuwY1rG5k2fgOzgWTA/rTO/NriReWRAm8c8tu/oEc
	ZKT/1mzk8ebLisiScVkgHb4RzswPDYgi/bBFL
X-Google-Smtp-Source: AGHT+IF44XjYngCZ8eLUhbWGRFsRASvEhApV5Zb7EnuduDNmFQ2HllL4LplMRCeD/E33eirS9R2OR5QzF4QYcVIzYOc=
X-Received: by 2002:a5d:4985:0:b0:368:4910:8f43 with SMTP id
 ffacd0b85a97d-37177744ee0mr3834274f8f.3.1723708621922; Thu, 15 Aug 2024
 00:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814163722.1550064-1-ojeda@kernel.org>
In-Reply-To: <20240814163722.1550064-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Aug 2024 09:56:49 +0200
Message-ID: <CAH5fLgi1xpuH1KpwSTPkiVsPsQ6YUC1=XhEusf3bXoRVyJefQQ@mail.gmail.com>
Subject: Re: [PATCH] rust: enable bindgen's `--enable-function-attribute-detection`
 flag
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `bindgen` is able to detect certain function attributes and annotate
> functions correspondingly in its output for the Rust side, when the
> `--enable-function-attribute-detection` is passed.
>
> In particular, it is currently able to use `__must_check` in C
> (`#[must_use]` in Rust), which give us a bunch of annotations that are
> nice to have to prevent possible issues in Rust abstractions, e.g.:
>
>      extern "C" {
>     +    #[must_use]
>          pub fn kobject_add(
>              kobj: *mut kobject,
>              parent: *mut kobject,
>              fmt: *const core::ffi::c_char,
>              ...
>          ) -> core::ffi::c_int;
>      }
>
> Apparently, there are edge cases where this can make generation very slow=
,
> which is why it is behind a flag [1], but it does not seem to affect us
> in any major way at the moment.
>
> Link: https://github.com/rust-lang/rust-bindgen/issues/1465 [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3Du5Nrz_NW3U3_VqywJk=
D8pECA07q2pFDd1wjtXOWdkAQ@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>

