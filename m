Return-Path: <linux-kernel+bounces-315702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4096C5F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5D5B245C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253181E1A29;
	Wed,  4 Sep 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zZJr+KII"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB81DCB10
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473017; cv=none; b=jAmQG9XV42hVaVw/cQRkamuTdhZldxw+8ufkHh3LeoWD6jXieOGyfvctqRpJEzp7bVC+lZKQH2HwT4bsWjfe4Vw4G10PQz84boNLXrf7F5vsw3YtE2QlEckl62iCDo+lfUWGMDLPOvigEU3Jumjw4x+16zIp1dgPLoEFfVtTP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473017; c=relaxed/simple;
	bh=sGxD221mI90raKKqY69Jrvx+alI7qWayFZJCwsVmXTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzrdYF6X2/jdFnsdqwZgRh4s2X1l2NExesFiwbO5ng4B1ybeQsO8pJyCHueN8pLb/keNCDel5fAMjgpalCpO48mk8e0DDmEPAGPSCGwfp5y1/t+kcgtnlwpVRAYpytlgt9NupGAk+SO12CpWjXXxQImQWJMr1KXmr28njFqUk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zZJr+KII; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a8053dc6e3so67148285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725473015; x=1726077815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGxD221mI90raKKqY69Jrvx+alI7qWayFZJCwsVmXTs=;
        b=zZJr+KIIdds4AGOAQG9erCj3mZ4EdoG/F8ypsQtehbw5Icqc/8SJaeq9E1cy7A/9Ly
         iOs/kQBrr+hDqSY7hOtozhF9rV2EFSROOuUAP0eMc1a4Yb0cQlOBYjUlD49IuW4Y9Gi+
         GCGp9ljS26lQDuUUZzsh81qwkFrnd5B0CrxWl76LVQB3iKsh2cNrMQo3fe372s25/9iu
         FtEBO39E42A2CPAl1Xq8zlb/SKOMGacXEoJUWExLO56wQVBd3Nywl3/lNla9FYa8BO+v
         ruOole/vlaF1IjRCRfxn3M56iF1NK0Z82nmgyyiVPwHyWu15jq1u7i6Y8TfbQP2jGUt8
         wtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473015; x=1726077815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGxD221mI90raKKqY69Jrvx+alI7qWayFZJCwsVmXTs=;
        b=wCbsY9yPJdewgn8Mx5/KOY+0P3ulUGgLQR//Xszdg4zc5dTot4Iy1fEKbea0SSO4uW
         INInISaL2QrBhSK3FQ/RVXSFlOY5Vju1GOHVThKrIX5z38geq2d4Uy635W8U/GB9jQS3
         R1GbVO4DbLYWXWo1G0F2DSnh13jQthYwPKspWqjNyzARzU0rCH3McdwrwQxcgL0imJKF
         glsDISKtiMD3d37NOQ0o6zzjb81VWGPrOvPkQmBqb9Qt1Nbq0IfhRe5kaf6FPrpibNGu
         K5xxDMgtvPm8Xhx3wlbjWV80gF7IpwNRGKM4bvJwbyu128wBdIYYzA9XQNGhRccintMu
         7cAg==
X-Forwarded-Encrypted: i=1; AJvYcCUYvZiZ6Z522T4PIPkrSckQS4V13ZHsuXdttCJF43pgYeZ6Nj2wDqtkWymxPZchZo1yU6cNQSDMC8Eesb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznthZFPkjaq56yuJRM7trMpKF0tlnXJhJjIaTLrV8R+d6WXFdJ
	Z81CaC7ZIuNlxC+onP5dMjLThtru2ENs7v9yfdE4ub0nzitS0HQb9FPBuP5y4BgSoSSBu4IOLxW
	NjM06BXPPhxIgQAt2PXML1oJ1xGsH3PpK9ppl
X-Google-Smtp-Source: AGHT+IHBmJTTHN2Wmj2krBKYeUJNhB5p9uqzsqxdO8mlK2mkQ3IDyZ4DJz70MF5sZsUtDnLHJNbztr+CG+65CRyvY3w=
X-Received: by 2002:a05:6214:320a:b0:6c3:6f34:eba6 with SMTP id
 6a1803df08f44-6c36f35002cmr72924326d6.42.1725473014610; Wed, 04 Sep 2024
 11:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904144229.18592-1-ojeda@kernel.org> <CAH5fLgizixTZ8nytkSzSLA67+f=zWZZKt8xTJ2BQg5K0ivAAmQ@mail.gmail.com>
In-Reply-To: <CAH5fLgizixTZ8nytkSzSLA67+f=zWZZKt8xTJ2BQg5K0ivAAmQ@mail.gmail.com>
From: Matt Gilbride <mattgilbride@google.com>
Date: Wed, 4 Sep 2024 14:02:58 -0400
Message-ID: <CABVGRke2nj83ohcBg_Q4RCKHuVVXP86jiL=moZ8x3fBEuKv0uQ@mail.gmail.com>
Subject: Re: [PATCH] rust: avoid `box_uninit_write` feature
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:43=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Like commit 0903b9e2a46c ("rust: alloc: eschew
> `Box<MaybeUninit<T>>::write`"), but for the new `rbtree` and `alloc` code=
.
>
> That is, `feature(new_uninit)` [1] got partially stabilized [2]
> for Rust 1.82.0 (expected to be released on 2024-10-17), but it
> did not include `Box<MaybeUninit<T>>::write`, which got split into
> `feature(box_uninit_write)` [3].
>
> To avoid relying on a new unstable feature, rewrite the `write` +
> `assume_init` pair manually.
>
> Link: https://github.com/rust-lang/rust/issues/63291 [1]
> Link: https://github.com/rust-lang/rust/pull/129401 [2]
> Link: https://github.com/rust-lang/rust/issues/129397 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Matt Gilbride <mattgilbride@google.com>

