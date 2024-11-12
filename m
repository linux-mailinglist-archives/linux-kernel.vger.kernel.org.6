Return-Path: <linux-kernel+bounces-406877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B619C656E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED19E1F25851
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886C21C18A;
	Tue, 12 Nov 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY11IDJA"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B501F77A2;
	Tue, 12 Nov 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455275; cv=none; b=jUImBpH3Wb9OyPeEmRzO8ZBhzSxNgp1LKQ068vgNb6aqBU1USVU1I4pI6AEjQNrQVe4N8UIeCGKKZJ0+imylDvEVhMtwrD4r7hTzjzO5v6p1SSroskSFA8pcfBhYHLgpyKmPAuMCokSaDfxihyyRWpuq297SEwra/EcHZpocJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455275; c=relaxed/simple;
	bh=6PatZ+Sf9io9a3r7pViBb9WFUEFsWg8CxDrxx4WGMYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2g9N9+J8LRVe1nYQm36UqX+XbDlHSaWXzcz/cZczbx+LZtTEzN3APSH1pm5TMCrUusIOPGSu/K0UGzQbPZDRFfS1gG4W7SMkVpRum2obtNUGt7alMzR/OAjh6CvQ+dYmrXdLIAkAIW7rc/OIDfh0BfhlkhrHpGobYVEffrf+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY11IDJA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso153833a91.3;
        Tue, 12 Nov 2024 15:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731455273; x=1732060073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PatZ+Sf9io9a3r7pViBb9WFUEFsWg8CxDrxx4WGMYg=;
        b=AY11IDJAYTIMp+5nRpWzwxfiam2VfJnzoGbkq7EjE30M062PSK2x76ZeTw802B/jhc
         x1HtngfnxU4ZJ+WU2fUhzGPPIWhMRtp4JGvgk7bz2azrHNBXyZzkSGq4gWvsJI8mzHZB
         /ualMnicwVF4XL0/D8j1r5ae3IjNxjUhNkPF51yMxN+stnKrlHVUBQblriDXdkfD1jzr
         8lkzDXtdl/i6eoCk0blYqWYN377+U4qksjmklqCc3YDWuBIO7CcDzdjdaOqweEuCFdaD
         lTXkuhQoNiAMyIhScPH57bHPBev8Wh3p6NqxaI0x1HyXuvKZdegpTbD4J1zLJKKL8k/9
         JlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455273; x=1732060073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PatZ+Sf9io9a3r7pViBb9WFUEFsWg8CxDrxx4WGMYg=;
        b=wv1R90LeVsIAjVeM+dwPmeY37uUIKp1XrH5nSTj1fJMnQyutc4gJea5zbKaABJGQYc
         Y5zzrXpoTErFNjnq39GdrwQcvLfAaaH1gE4CtkpDnp8QP6TXxMq8DqCAR8zF8qpjrcN7
         S+IvVxW7LKz3/xE0WkJh+gAOnq/9XGHYWCgffij2b61NnUPp4r7QS/tPtuQ3F/EbBV47
         wU5rLUGdc3c94T9/Wc8vzQIrOgqR+QvMja5O4NawpyX/uiVS9XPcx4oPCxRqTCjcgrVD
         5VBkBr/bz9hjPTq/6Xc1/hImxdBQc89z9CcIysoDyw9acOtFL6prucD/122Ro2OoJB72
         JIlA==
X-Forwarded-Encrypted: i=1; AJvYcCVE7ynoJ5d95cLk0DRFwxrj0GkMRLAOhc+kSwdYeiFz41hUmBFMwZ3xShVpGsPBqepvfaZRuEY1elqnacCcbGY=@vger.kernel.org, AJvYcCVk5MEpyR5/KsCgOploNuTDgAk0oF2n3TCsF3rV+heswy5zQP7fGWAs1sZqB/RWBnnWFS85Od8bWeTzJ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYnFiOCp7UBt1kD/d/tmRK3+QCtYSQtCRCNx+d7X2MsClYP9/
	bBKGJftvfy0vrwaZGlC5K/BnLAkJF1NQ/KTfVc77iyl6qm9Uj24vvxi5a6kbx96LW+5wI1GDDdo
	MVyxzYY2aVpKFdWnEgEVntJ+UsX0=
X-Google-Smtp-Source: AGHT+IHt4zpo/VBRqQpkngufkrIlPmpL19n7RePvvPWIV425p6qC3p2QZEdY38kGPV9MQ/jFliQjsJvM7Z+x4V9/uQE=
X-Received: by 2002:a17:90b:33c9:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e9b16aa2cdmr10229180a91.3.1731455273486; Tue, 12 Nov 2024
 15:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111201607.653149-1-ojeda@kernel.org>
In-Reply-To: <20241111201607.653149-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 13 Nov 2024 00:47:41 +0100
Message-ID: <CANiq72nPdcU=E98pE=WM_e=0HPDY7Evg_pto87kf6N58uYbYtQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: warn on bindgen < 0.69.5 and libclang >= 19.1
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, Ben Beasley <code@musicinmybrain.net>, 
	NoisyCoil <noisycoil@tutanota.com>, Matthias Geiger <werdahias@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:16=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> We would like to put this into the merge window, or ideally very soon aft=
er as a
> "fix" (it is not really a fix, but it is very convenient for people wonde=
ring
> why their toolchain may not work, especially if tracepoints land in the m=
erge
> window as expected).

Applied to `rust-next` (tentatively) -- thanks everyone!

I will wait a few days, and if no one objects, I will include it in the
PR. Otherwise, I will remove it (it is the last commit for
`rust-next`).

Cheers,
Miguel

