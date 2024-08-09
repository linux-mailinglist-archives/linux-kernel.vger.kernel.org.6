Return-Path: <linux-kernel+bounces-281599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5763294D8A7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470881C220C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10D16B3A6;
	Fri,  9 Aug 2024 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAGXeTcW"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821B62171;
	Fri,  9 Aug 2024 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241765; cv=none; b=a6D/4T35sBCj5yDZ8rAhRXqUbps4HRwcD1CeknN1gG/zgEaiWxipzhpMvtZrEiUHl9Tlkjh/N7ikRun8eByF+BsXt6gWAlA3XSjuybOnswKffh0sjk5xIsHorGjQ5KnRy1ZbBgFbIg/GazERneiWmDBmdI7JxeksZrllZI2A5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241765; c=relaxed/simple;
	bh=Vyz7mOQSobTax2GI/PV4PZxzi76IZVTiDNoNh8/txbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIPYurQcIwD+KY8G2WUma4xE7hf0bsNzd5t93AtEkGsLPEkU9g2z0+pn6SOoveTNS4sf3uaEUEePVgXQTJJZvBj8tjVjBNYtO4YVuHfR+17RPWxAQLLWPKo4TvJlESTezB1sA9dsm/brb3T2lbCd4vrIjNGmLfILiQtdcEhyq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAGXeTcW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d1fe3754f4so110595a91.1;
        Fri, 09 Aug 2024 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723241762; x=1723846562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QajCiM9J1gZRiKmQalSp88+y2PjJcBm2h12qCDW+tY=;
        b=RAGXeTcW+izDyZ8ldcXoG7+CfOij1gmziunJy+JJPqwo7eGaxQIIzv0DEkEGjDTnr+
         eQ91CQm44AZg+4g6dme4hLkMmgCfaqIrNmlOVeKFLew6RsnDAkwnKt75WVKAu20D2YB5
         DTSlzGjgxgeumfYOZaT2TwQ/xIHYxyqsbu9xdGSt8l3xTI9QNYie8Z8ADvHdKd3aS3+Q
         KaUwcSHIPYvVMDNk6988nSNhwwhAMfspLrYYyzN3fnbN0/7/WJEkmuoX5RjqZsB72lfD
         M5J+UCZl0mlPLjftvMQoe/H2iNu4mHuXk1xjMRhWG3SoRULa+Ibb+hLjl+KZnRwS+/dR
         U6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241762; x=1723846562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QajCiM9J1gZRiKmQalSp88+y2PjJcBm2h12qCDW+tY=;
        b=OtVKp0RUfdpLYgd0Dz0zj4Wh8bgEPfwjNrFm/3IxJ5CCPm92eOdtA9t1sdQkuQOI/U
         vVycAZi+HSSb0RjKNqAEoS9kK9z0jJarNjPIacbWvfw8oTRMj6dET/VB7Ks2tw5EjHDh
         NLx34bfsliWNcMunbgy5zMEPGAoClVM5kdK/vlisIvKrqQ6GJAO8niYpsGb/j9UH0uZD
         41/ECBTwo2ed0XX6og6YNCHyOscTsJ8vxW5tTg49kJApXrMn0NYBHMrq+cThRShwb8AS
         oeom5cqlWkGbN1MY01ysf+8sLACdtdk4CjOft8a22XnkAd4kVIIXWjPIS8HDt3Ak8vbr
         YuWA==
X-Forwarded-Encrypted: i=1; AJvYcCVeh8rNuK4mK9w6O1R8zfQOYpHBhLDgdEOvVjOC2M1v1OBPDR9tLDL4L1qSNU8V4fbRDVnNdjW61M2LpFm77jvoFLLAJbERFLosGdVChgauZqUm+QuqdUdmxZvbJoF4cFCnkey2fTBPp1Ycths=
X-Gm-Message-State: AOJu0YwaSmxZ7X4fIDsFuXsJO4YTknwnuJ3+W6SEMFgBM9u3E6wNR/Ae
	oIjRraIUEbLLWICtMr15phEkKu9WVrYQRwcGt2HzsfuZJ+jvuKzBim2WOX17uU10Gdvs3S1gANz
	mhfRGA+Bv7DuAHBjzWqjdJo8wxzA=
X-Google-Smtp-Source: AGHT+IGqhAIMpdcPgTvG4Lm0bG1VLto7lgkIz+dlldbt0bpWrxp0o616hdq+TZ0DclexAS+zwSJY7UTJsSeXk+LcnK0=
X-Received: by 2002:a17:90a:b113:b0:2cd:b915:c80b with SMTP id
 98e67ed59e1d1-2d1e8082b97mr3276313a91.27.1723241762470; Fri, 09 Aug 2024
 15:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144558.114461-1-ojeda@kernel.org>
In-Reply-To: <20240806144558.114461-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Aug 2024 00:15:50 +0200
Message-ID: <CANiq72nH9KZZKtDsMkfosmHpgVjvGM6=yy7fRyNP2NrDFUrkvQ@mail.gmail.com>
Subject: Re: [PATCH] rust: x86: remove `-3dnow{,a}` from target features
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Nikita Popov <github@npopov.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:47=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> LLVM 19 is dropping support for 3DNow! in commit f0eb5587ceeb ("Remove
> support for 3DNow!, both intrinsics and builtins. (#96246)"):
>
>     Remove support for 3DNow!, both intrinsics and builtins. (#96246)
>
>     This set of instructions was only supported by AMD chips starting in
>     the K6-2 (introduced 1998), and before the "Bulldozer" family
>     (2011). They were never much used, as they were effectively supersede=
d
>     by the more-widely-implemented SSE (first implemented on the AMD side
>     in Athlon XP in 2001).
>
>     This is being done as a predecessor towards general removal of MMX
>     register usage. Since there is almost no usage of the 3DNow!
>     intrinsics, and no modern hardware even implements them, simple
>     removal seems like the best option.
>
> Thus we should avoid passing these to the backend, since otherwise we
> get a diagnostic about it:
>
>     '-3dnow' is not a recognized feature for this target (ignoring featur=
e)
>     '-3dnowa' is not a recognized feature for this target (ignoring featu=
re)
>
> We could try to disable them only up to LLVM 19 (not the C side one,
> but the one used by `rustc`, which may be built with a range of
> LLVMs). However, to avoid more complexity, we can likely just remove
> them altogether. According to Nikita [2]:
>
> > I don't think it's needed because LLVM should not generate 3dnow
> instructions unless specifically asked to, using intrinsics that Rust
> does not provide in the first place.
>
> Thus do so, like Rust did for one of their builtin targets [3].
>
> For those curious: Clang will warn only about trying to enable them
> (`-m3dnow{,a}`), but not about disabling them (`-mno-3dnow{,a}`), so
> there is no change needed there.
>
> Cc: Nikita Popov <github@npopov.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: x86@kernel.org
> Link: https://github.com/llvm/llvm-project/commit/f0eb5587ceeb641445b64cb=
264c822b4751de04a [1]
> Link: https://github.com/rust-lang/rust/pull/127864#issuecomment-22358987=
60 [2]
> Link: https://github.com/rust-lang/rust/pull/127864 [3]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1094
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

(If someone from x86 still wants to take a look / Ack it, please let me kno=
w!)

Cheers,
Miguel

