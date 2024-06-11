Return-Path: <linux-kernel+bounces-210654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448BB9046CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6A71F25475
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACF155307;
	Tue, 11 Jun 2024 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRa6VIsc"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693E1553BC;
	Tue, 11 Jun 2024 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144011; cv=none; b=dMPK7GVydzIxKr3cc2qmKWX+XGAAE6/BJLz/0QYcz3ZpHMD74nMAMmn76k5AYSiEp5fhztnwIsTdzwPePeFUOWYdwHBUqmdVylUkdPtW4n3rRkRscBcCjsvUhmgmB+oHqIteMD7twYu1U1uvOdT2zq3H85Ehd0bILlakEOZFV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144011; c=relaxed/simple;
	bh=jJPNqfRI/Cz7z2/d2q/YscZrx1nNwYFta+zUuMDS5wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnVRFUX+7x38Gt+W66PtICFlsmvzb4pssDhOBzPHLOfF0JfuVQqfcsG8PYl4AxRuZSiVoHcjsZxADq/Cj4A+BnsR9Pgr0BbIYABQrOKFwETQESPkgHiYUb6NwR4FkR6R+dychP8pWG9uiuf50NOjbv6stDmsfl+BIw1vctH2fkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRa6VIsc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c348a263easo253294a91.0;
        Tue, 11 Jun 2024 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718144010; x=1718748810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afhBt1R47m/ezKSoV/9ouvvCFpR5TvvNgsKkb4qH0kc=;
        b=RRa6VIscs2pdvpDYtJc/BAS0BTUUJLx+lgrYXKplAM/gv2i9EtGh0AfTEE74mar0Ug
         yyKVZc3ueazT1zm/KT+EphmBcPEVFumypSvmnNcJAIrBJ9aj2ELb0YI3iySvTARLCYHU
         AntXxOQbVEuY4JCLsLlXTR27CVqVe4hx3H8xyQpw2epyVpb08Ew42doyaxrPT0nzbjZw
         wdgpn6ja/HUyKz2j9/iYc3mdgKyeAP5XIOQ2O0NKRjOdfjGjBOi4c2hn4g57GGL6TCbt
         QAS+LYz6nor7SdbASnQMhsyC2hPJfkRrrnphjuziYbXcTgTasa9ypoIEjwg6ctKbtDl6
         2kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718144010; x=1718748810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afhBt1R47m/ezKSoV/9ouvvCFpR5TvvNgsKkb4qH0kc=;
        b=Fvt2eYnv8S5Z2idGbWkBKoGwREpx7DLxzR/uOOgKQkIaeD1uwGfn65baVKRIpKvAXD
         gkjxwf/snTBI+mgv9F0RvR0gWOhWPOllb8vIqwDLc+hHQQuHH1o91mmhox97YkwY72IC
         4Ogkxn8sSGkKB6CbmyysmkI6sPfh4t62xu7Q6/Uv+1I0vwbQD90Sjf7p/Ps2+o864nG5
         MH0Z59lFOnaS9jjLiiDp/fvjI/Eg9s9pgmRpoaU1GJxoiyP91+vB7V5tvVk4a+X9CaNz
         foKiYSqHWebZiLTnyZHVb/tRXUecfB/TLic3xEqlflEO5qD8l3KPs4BShUe2Jcyr1zKo
         z0GA==
X-Forwarded-Encrypted: i=1; AJvYcCWtUnlJY1PqXosIE/T6P0YuCisefFIWG2hOjOtpg0Nbtv+BadMaPEtwd6NzmksgqRzDj4Y/pdpEc3f2dc+IfuDGnqyeeOgXQH/1cGmxcH0U8z4F+3TLlZBUZCNxOZANDLYhVc4Gs19MWcYoImI=
X-Gm-Message-State: AOJu0YzrnzExKiCrrbQPHZCF2kjKQlckjdmp9oW7qd5NSLs/a04XWIp0
	orUJJGt8W/RekTPdIwqViubhViEi9JxSjEFWFjJRb8vM7/VTGPCK8khY8koIhISwKSYuYK+vQFw
	9Db6tgbp+CXR4GqYpdwnSNBl1zQw=
X-Google-Smtp-Source: AGHT+IE9qlCqOLeQ05QKNJPKnN7tKouREQ3dXdvn72wh7ojH+wuSAOzWfyGt9Erib8sm0i0A/GgDresrtb8V839STDE=
X-Received: by 2002:a17:90a:6fa3:b0:2bd:801f:dabd with SMTP id
 98e67ed59e1d1-2c4a73a5950mr378332a91.3.1718144009637; Tue, 11 Jun 2024
 15:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519210735.587323-1-ojeda@kernel.org>
In-Reply-To: <20240519210735.587323-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Jun 2024 00:13:17 +0200
Message-ID: <CANiq72nXkNY2EUd_6noS-ZZ9xKa0sBYcby1QCovA8V9VxwTNXw@mail.gmail.com>
Subject: Re: [PATCH] rust: avoid unused import warning in `rusttest`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:07=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> When compiling for the `rusttest` target, the `core::ptr` import is
> unused since its only use happens in the `reserve()` method which is
> not compiled in that target:
>
>     warning: unused import: `core::ptr`
>     --> rust/kernel/alloc/vec_ext.rs:7:5
>       |
>     7 | use core::ptr;
>       |     ^^^^^^^^^
>       |
>       =3D note: `#[warn(unused_imports)]` on by default
>
> Thus clean it.
>
> Fixes: 97ab3e8eec0c ("rust: alloc: fix dangling pointer in VecExt<T>::res=
erve()")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

