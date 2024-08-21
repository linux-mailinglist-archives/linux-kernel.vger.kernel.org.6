Return-Path: <linux-kernel+bounces-295464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D0959B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42879283293
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2C17A590;
	Wed, 21 Aug 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="el4ac9Ch"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5A1514E2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242141; cv=none; b=plsmy6342mbu9s+DDT3D7l/DGWhdbFkEj9+Mj+HOiqwkJR6cNRzucWpD0Fjkkdtv4Mu3w8Je7CoWV+rcBgjmXSsP/bwkCp3e7COeaaDmuQOykuT2J4bxpBc3xgVkcyWUqow1mExCZrj+tBkOxb75nn+0+dSwz+rm4EOQ6Hb94Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242141; c=relaxed/simple;
	bh=DA1X9Ve0Vn6diqrYfPjFkkduWMPJiWV9pT4xIJEPvqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7l+a6nWBATCZoEy6CPcWbRXG8zMw51w/i/KbEvLC34I3fLcBhyu1iRvO//xR+Zsz/4Ludakq7Xbl8dZo1nBW7Xke00MFAw49Aap1LPk7mFTYu1puAJWSVedoCWdRtYHTuusDYk+kmK2RClKFqpVc+ky2gjXwMAiE4REPNL/40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=el4ac9Ch; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37182eee02dso432314f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724242137; x=1724846937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDwqhRHhMBQJ/+TLyoRpyJFlfsxxIUrIdKu8FSn6JKQ=;
        b=el4ac9ChIdU3dbBwOzt1Ipwcxb58MCdsiuKZO3aBWpLg7jNbUs066ybdpBPeCYXCTn
         7gicQIB1zld37AXYhH5LqLi5QzYsaMWDfWln8mU8FGHaTmcwg4plNC7FxPOCOVr1WoeM
         YJZOMOBMehuGPWIDYYukie6A1j0LoQbimC9sEqdsljqKu2F987/mcxABHlMHETQXW/6z
         2PlpI3gKBbvHJPY3tna82klmpc1iFjRXYV7Gg3MfHccFrdUy+/skUWRs5xU34Y+v9IL/
         xCOcuZhEAYb1Wk5NB3832Z2tKroexKQrUsZfhTf+V0Zy/o9NLuwfCAnn6Vdx9huXTllR
         ODPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242137; x=1724846937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDwqhRHhMBQJ/+TLyoRpyJFlfsxxIUrIdKu8FSn6JKQ=;
        b=amGDy3yiFHwVjbTJFAx5OqllYYCdb41LaYe7gSCJq+GfB64iJKEZyFxq+ZhkbDDGBd
         78p+R1ZDjLrqiyWyqdKjrDvNGi5UjHcyywofwZfH+thwZN+umKPgzLGMBbpiTBQ8vaTv
         is/lOz20Nao/+S9YYSvXKAwmjmTh0V0iUfbI1CL67YJ7UZyWAiPMoMU99Bzd3LdgwsIe
         m19S+WEUWuJyroEzpF2yv6FnaWtYIsNmHxRodn3rlksL80shF6b3EfznJcIK53+WQ20F
         aG3sNNW41KuyxhaAkMZoakonPxVeNmAkJwu5WwyVkB0oQzagveQlsxc+PqYB5mn9+Mt3
         Ov8w==
X-Forwarded-Encrypted: i=1; AJvYcCVo5OBR3wY7MeV82tH41WfUdI5JjJ1CM/kvgyDXDPyklw6mkPMGf5xQE6rMNAigddXd7/SX2jsXfupZXE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKv0mDiEp4l0EG9TiukiMiALgla1+RINOxom2tZVAvGNsAeFR
	ADDpPp3wEUzlT0tee8SyU98cZymrNnOq42yXSMNWgH9JJ93EQGuT1juev0kfLcCwI8ElmcdCklW
	HLYqdvD6R0HdBmmbT+dFlA5Mpw57ssZ3EmXNY
X-Google-Smtp-Source: AGHT+IF/+B4e2rOwDucRvS4kWT6EeKo58j00U+Ub/62J14Eex9C5zjjnxt5zAjMaLCrIZo2JrYvwnhV20MJ6wjBJhW4=
X-Received: by 2002:a05:6000:b01:b0:366:dfc4:3790 with SMTP id
 ffacd0b85a97d-372fd98d681mr1189198f8f.0.1724242136775; Wed, 21 Aug 2024
 05:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com>
In-Reply-To: <20240819153656.28807-2-vadorovsky@protonmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 21 Aug 2024 14:08:44 +0200
Message-ID: <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom
 `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Tejun Heo <tj@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Michal Rostecki <vadorovsky@gmail.c=
om> wrote:
>
> From: Michal Rostecki <vadorovsky@gmail.com>
>
> `CStr` became a part of `core` library in Rust 1.75. This change replaces
> the custom `CStr` implementation with the one from `core`.
>
> `core::CStr` behaves generally the same as the removed implementation,
> with the following differences:
>
> - It does not implement `Display`.
> - It does not provide `from_bytes_with_nul_unchecked_mut` method.
> - It has `as_ptr()` method instead of `as_char_ptr()`, which also returns
>   `*const c_char`.
>
> The first two differences are handled by providing the `CStrExt` trait,
> with `display()` and `from_bytes_with_nul_unchecked_mut()` methods.
> `display()` returns a `CStrDisplay` wrapper, with a custom `Display`
> implementation.
>
> `DerefMut` implementation for `CString` is removed here, as it's not
> being used anywhere.
>
> Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>

A few comments:

* I would probably add CStrExt to the kernel prelude.
* I would probably remove `from_bytes_with_nul_unchecked_mut` and keep
`DerefMut for CString` instead of the other way around.
* Perhaps we should remove the `c_str!` macro and use c"" instead?

Alice

