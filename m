Return-Path: <linux-kernel+bounces-516724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACBAA37641
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AB73B0BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D019D88F;
	Sun, 16 Feb 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8aL1wut"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7FB18DB21;
	Sun, 16 Feb 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726581; cv=none; b=s3ep7Ncu/GDZXYAJ6huuddtT1MU1MZAy48FGF33BdMnP1nYrfAeFDx9cNB5/uOPsBi78PwvZf7WscKekxTtz5gFEXWWEej0brzdDkVPwVZyz40Fu7i0r9b7w55qFiU3Q5jhCk+XbdiOaDKULAbcSmFr/v16euZQ0d9OuIva1ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726581; c=relaxed/simple;
	bh=NAzaBhSr5n+TYvVmnCU1DeLwwCM+jSXTBiJA0WcbAq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTtuuGtFGGMVGXhKD9iu4H+urXp4t56NmcpbEGRODGqsCwcK7gM18hcON6B5mRzeyl5WTvxgGkjJZphHE/xslthld6Op4zYxDN10+EZwblUk2p1+V+5BPFY+jnDM78R1VUQyy+TYFSnMH49BIypNj9zzzy+QYBIEH170+VxmLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8aL1wut; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d47b035fso9244255ad.1;
        Sun, 16 Feb 2025 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739726579; x=1740331379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAzaBhSr5n+TYvVmnCU1DeLwwCM+jSXTBiJA0WcbAq0=;
        b=X8aL1wutcDdpymkJUXxhRkqfhbsaRxlO12okJdfdhtEl+sKTF3Q2gByOPncQ7eMe09
         suFoO3I2MzmRglTvvUuDaxjUDK398afHGIvhufQCjvUdWNP3k/gxm3DREfUMj9N6/gVY
         aJOkcRGxcAi0d9XG+LvEGthTdAoiYQAP0ovtr3GsKvwM9VxngYwL4HlNcCI71vXuFDVL
         EF3LhsLn8XeAQy2K75zd15J9QX3xjBSmm0Ml5Ksz+46cHQpu2O0CjS3/5Qsp4ef1Tzee
         iCP53jHrPF8lU6aUxBq3TOwObcpQduX1k0cLzNlFcIn9hUCNpnC6TDu5Htsqqr/65GM7
         Y2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739726579; x=1740331379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAzaBhSr5n+TYvVmnCU1DeLwwCM+jSXTBiJA0WcbAq0=;
        b=D1q7yk3Cnd3QZcWo1GXbsDPx6rtJP56kFzflyliVOih6WX23t7P8b5Qezwyk4c5kWQ
         vvRumDQvLu5QtfmFmpScSRI+4u2K9lzxPpe3LVbAkuyxjmyWdztx3LMCRnlr3gZqCZ0s
         kzN+e3VTrMzjkR+szOW3yhJHu+FQxWRXJV+3ZUG5Fsh5NcWEuwfUoaAOjIGGcfyE8/vB
         S0Zf7aE/S91wjRkYkl/bY9rR0HxGpGLicj4U3D0P9oqfacXonMj52A1yXBfy6eynSQWo
         7ZvxxW5YoRURyN4jIRkHHgGqelDpAbtyilP2nhEIylZ4iBEqLn+JYBbeS3Tfn9J6IfLp
         Zvow==
X-Forwarded-Encrypted: i=1; AJvYcCXV6LQCO2GcSEsJQMWcmbTMV911AnUlfcuQZ6zwlb7vCR6hmVTgoWiB9LNw+qYkZbn/s6oFXWvT9WPbtzXIngU=@vger.kernel.org, AJvYcCXr/ZbvBshyJ7l0rhLH+Jl0klVwPm5Mcp/vgu99rNRFb/CPGr8GDnrs/+if+X58wr8pm2OORghAHlCSfGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rd3lyM9wpXe4CaqibCo+xIQnXRfjcK4bL38QYKRSTugzImRX
	krPpvuOntv4hRVnjAm/v2zqat1qBsuesiqMd+ReFT2CBF2i7AaBR6hstKrXN5xbPOsrilWkPq0y
	DHADy9GGcHf8QE+9n9ovSfdwIif0=
X-Gm-Gg: ASbGnctzXp8L5LsG6W3fvd9Wkm2E2AVTya4XuhjYdrN9P8yFCYUCPxicuyE8QERytFc
	wzYy+JsA9x9bhnLsEys7w5X64mtk8crv1doY2EL2jpGVZ7ScU+PPgHAaBE6wnoC+B3u9G5PYx
X-Google-Smtp-Source: AGHT+IG/evLlrI4UrJbDJlkGEG/b6g1tNJfJ8LkVEgd2/l3HmpgO7AFsqYpgoH6COZaoJexw1WzBcMeSe7shaT6aU4Y=
X-Received: by 2002:a17:902:ce08:b0:215:2bfb:3cd7 with SMTP id
 d9443c01a7336-2210408b39dmr41676845ad.10.1739726579566; Sun, 16 Feb 2025
 09:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215223106.2346285-1-benno.lossin@proton.me>
 <m21pvy927w.fsf@posteo.net> <10690211-eb3b-4b95-8d9d-35c62930d924@proton.me>
 <CANiq72myMWv87Me2C6Nmse-p=4YL=J+ZTEHe2hu7AhbpfZhgyw@mail.gmail.com> <10c0a50e-14de-4da3-a592-dc65753cec1b@proton.me>
In-Reply-To: <10c0a50e-14de-4da3-a592-dc65753cec1b@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 16 Feb 2025 18:22:47 +0100
X-Gm-Features: AWEUYZnKZihZQ0XKpup7IK-Cwnls2vvFh5EIHt1gsg2kWZeIxWUQwWvr47RI_yU
Message-ID: <CANiq72=1QvWpBi8zc_9_irU_GEn_50Fqpmqj3ANKW1WbuOvWOQ@mail.gmail.com>
Subject: Re: [PATCH] rust: fix clippy::too-long-first-doc-paragraph
To: Benno Lossin <benno.lossin@proton.me>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 2:30=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I don't think that this one is bad. Of course it would be nice if only
> the rendered form would be considered, but there might also be people
> reading it directly in the code, so it could actually be a good idea to
> also keep the raw text short.
>
> In the case of long links, one can easily work around it by just not
> using an inline link. (so having [text with link] and then after the
> paragraph `[text with link]: link`.)

Agreed, I think this one should not be an issue and could in fact be a
good thing.

> This one just seems like a nice-to-have, but not a deal breaker.

Yeah.

> IMO we can enable the lint (since the instance fixed in this patch is
> the only error I get with that lint) and just see how it behaves.

Yeah, I am happy trying that one. If you want to submit the patch
formally, then we can see how it goes.

In general, though, I think for "nursery" lints we may want to be
extra careful, especially if it may look like they will have potential
behavior changes that end up triggering even more changes later until
they settle (e.g. suddenly they change the threshold length or other
heuristics). For now we don't have that much code, so it is OK.

I think eventually we may end up putting some extra lints into a
separate group that can be enabled opt-in, and then promote them as
time passes.

Cheers,
Miguel

