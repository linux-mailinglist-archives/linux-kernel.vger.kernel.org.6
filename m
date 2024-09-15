Return-Path: <linux-kernel+bounces-330037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477259798C6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 22:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D410B21BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249F6EB7C;
	Sun, 15 Sep 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gk/i8tBs"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598338C13
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433731; cv=none; b=J1+1hkbOsPpC+r/aTrAqTEdMxDzuQ/+bJ/lT6paHLy1WVP6Fmhau6cHp1upWa7MhvRUJ+U1zT3qzMi/caG0BuWlLHL2OTq8f68bGU4pC4XyZqgFy5f1bjFSpTe9spM23sFzbb79NeLB4tNlMrFdPe6R2/3DV6e7jLsh+KI6Jucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433731; c=relaxed/simple;
	bh=kbZNky2ukXvY0Uc/WKbVfKtB+125N5NWRZV5J8lxpnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEjz/ZERFCceXvC5b2lZ7LcCdzfSlDMy9UpjNFfk0YoVRTZFuxkoPWP/pW69B5+9FBsVIEWBlfgmvHUtPpN9TewKE0aKfr4hSoqjP4jne1Oc+WjmHKiV+/oG1XrRgWIhPFLPFqVtyn3qkkYZBsr4gZS70mP8kyiR2ezzv2b2n+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gk/i8tBs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c6187b6eso2901312f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726433727; x=1727038527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfyOcCKII5XM0b+CTX5LMl9eYoo09Pc3xQQkicZRlpw=;
        b=gk/i8tBsy71cOeQm258Fa49MCimEZtr28Vsw/bGbcx+0Uoc7w+aUgY5yK+PZj6MvhS
         jw34RVlPRwWkkkEFALmWcwfVq5KAr5uKSLz2lZOOw2KhRAzCF0AWCfyE4QB4g+wSFYgA
         HwtM9tAMAIgJeFlfPGESlhaePm01m729c6zT3GyK0LiEkIr5L71kSpKM24d2ZuDrTHCs
         A3977eyMPLWwrUQpSTpLh/kmxKOqC/VMJAw6KqTozEULV8b1QgP9F79yZIvueHUr4rUZ
         ibllM9wwHtJVM1tfsP5u25IqwVbZGEK+/MuO/MN0ZqMJAMr30JtbpO2CMHPJ7vxoulc/
         uVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726433727; x=1727038527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfyOcCKII5XM0b+CTX5LMl9eYoo09Pc3xQQkicZRlpw=;
        b=m7yYwVFNoJKIVhQGpwm7dZxoBiwRnD9Lv1LjI4ev0zP4Umhy+iFJmbV7YdZpATGXD3
         DkdGxybS1Z3kbubRofn9vPerd5XZuxSwHZ51e2iNH/C8C7HXZhxEyBWj3jfaOpRPcWmJ
         8iPxBL77Mr7aab09cgv45MsW2kLgCgcsxwlUopaADWQFcVPLgGrsQV+IqcziIXMfXGpk
         4PeSwkmC9C53/R3TE7rkM5X388WlSzoO0pfKuuOqKYnEw0TYN2qmINYmlvWiwuRaoe7C
         9BL8A1wGR24SUKWgIGHGeCcnx7XfGk+w8CLbq3W2yJgs0q//6/qO6mn9zqX+U7d8HEiK
         6h+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXn4hPKPOuQr5tF5d/Xs7mYYfB2ppoHfJ52GhtNx+NUFxDJjbeRWkG/fJrvFXC0zr641JfKRL/Qybj3gP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfYcV+O3oi06pGycPXeFd8Madh9Oq7L/9Gp6aSwiiiQoDjsh+
	5UKmKtus/N9UYaEc1w3ERAquTRbcsLhma0Q7ffRNDUS3osFc4GTvgjDFuHdB01KO5hMZ3v8aLFr
	y+FU5uLFWW2pkvUz0weuibG9cw9LGc3Nyn5Bm
X-Google-Smtp-Source: AGHT+IGWQFeQZDzyxBRRhaH5iScrdOKBeEJq6VtM+ljzHFnbYqYR/PmkuUpSMTFjiniQmsfNYWGWBK53pTW4OLn7fX0=
X-Received: by 2002:a05:6000:c86:b0:378:8aaa:9cd6 with SMTP id
 ffacd0b85a97d-378c2d62046mr7188675f8f.49.1726433726342; Sun, 15 Sep 2024
 13:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-4-88484f7a3dcf@google.com> <202409151318.7985B253@keescook>
In-Reply-To: <202409151318.7985B253@keescook>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 15 Sep 2024 22:55:14 +0200
Message-ID: <CAH5fLgjRpY9vYWw0T0g3R_zndvj6AGKHeHw=H2yM+C5-SHt6BQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] rust: cred: add Rust abstraction for `struct cred`
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 10:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, Sep 15, 2024 at 02:31:30PM +0000, Alice Ryhl wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > Add a wrapper around `struct cred` called `Credential`, and provide
> > functionality to get the `Credential` associated with a `File`.
> >
> > Rust Binder must check the credentials of processes when they attempt t=
o
> > perform various operations, and these checks usually take a
> > `&Credential` as parameter. The security_binder_set_context_mgr functio=
n
> > would be one example. This patch is necessary to access these security_=
*
> > methods from Rust.
> >
> > This Rust abstraction makes the following assumptions about the C side:
> > * `struct cred` is refcounted with `get_cred`/`put_cred`.
>
> Yes
>
> > * It's okay to transfer a `struct cred` across threads, that is, you do
> >   not need to call `put_cred` on the same thread as where you called
> >   `get_cred`.
>
> Yes
>
> > * The `euid` field of a `struct cred` never changes after
> >   initialization.
>
> "after initialization", yes. The bprm cred during exec is special in
> that it gets updated (bprm_fill_uid) before it is installed into current
> via commit_creds() in begin_new_exec() (the point of no return for
> exec).

I think it will be pretty normal to need different Rust types for pre-
and post-initialization of a C value. When a value is not yet fully
initialized, you usually get some extra powers (modify otherwise
immutable fields), but probably also lose some powers (you can't share
it with other threads yet). I can document that this type should not
be used with the bprm cred during exec.

> > * The `f_cred` field of a `struct file` never changes after
> >   initialization.
>
> Yes.
>
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks for the review!

Alice

