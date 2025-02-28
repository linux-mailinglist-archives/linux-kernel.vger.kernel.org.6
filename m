Return-Path: <linux-kernel+bounces-539030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639BA49FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29CD1883B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D11F4CB9;
	Fri, 28 Feb 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNQm1g68"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2011F4C9E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762680; cv=none; b=WdJ+PWVWqdjk6Y+iQCL37KFjai/4ZMpzn2hPxX2w1LUrMyvyx5vLVh4KmfxX/YsC8/qW8Ku5G9FaQ5LkzC+ruP2iBDDKOE4UsSQvJIQTAYlZ8CuGiBwPvpXMmhCvhSnLoSJ1XkZaW3UkDs8+IMEwa2/mSc4a/7oeq3YhtSUwfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762680; c=relaxed/simple;
	bh=Lm5tkiIKEouATjRnq6xZg2Gmt+vLmhfFkG47lHk6t/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLTntl5RutMvDJYWiSqvrOYOSHd1or5F6dirVQZQdwILDA7m6pLGY/qTzDVLSKEj41o6X3aGg5I0V70/LL27/yMu5l694pAsTzvkYzJu9H0EW9fWdTJIdQZC+S8/bH3IYMwiVUIP6ShE1Lbd50jb4u+C4iwdyGcXzwfSyObFZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNQm1g68; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390dd35c78dso1857045f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740762676; x=1741367476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm5tkiIKEouATjRnq6xZg2Gmt+vLmhfFkG47lHk6t/Q=;
        b=XNQm1g68iTqmYGn9Jpri6oV8mdVVtmrWixvKKh0LGCX4OEmF4zvD20drrn/rVGgkZo
         eMVtpgdEsmTH+iuz/R8R8QbzZfpeuC4bJi/XrTNhmQdkgF2+YpIpeHfDu/QHkNCX/X0y
         I4kqVNQTt+ytATvCpTZdXEMj4UkEv7tLy0CioztPjCDvVQL44gScfrtyz6HeKePcfxSH
         YqfwseNIdrBkHPe6WuuHzgWf+YQm1KIMlCeFJs7HM2BnwgB6eLbmnotse87ApQ09VuCd
         kkotxcOGPk7i2eAWwsTEfBWBENckWl5RLknh1vBE5ksRpWhdYNpmOsaheVFulXkB9JKU
         YV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762676; x=1741367476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lm5tkiIKEouATjRnq6xZg2Gmt+vLmhfFkG47lHk6t/Q=;
        b=YE46183Gs0/w9x9CKM7Lj4A7VXGUq9D0Akf1HTbYVZ7N1ukk8fXHUBNk4pQieG1uzy
         Q7vDK4Y4bynKXBs18LUSxV7QEugGh6y75V7Vok0QWoK+c8FrT9LIFZgYZs7r0Q5touXV
         V+bV3RzCEZ5pylTmynYt1bemt47w8j6vmZwdAKEcZlHNCNczlk57xyhFBYGV3tN6nANS
         dtmz39HNasZJxjMWiTJjhwbWPEpeuL39V7xDTW7JvjX5PbwFbxkZ8ewURSkI4JS63bH0
         bEjdTbIODF6m0TOPKfrCovMBGMwrzU/ZIAXqFrroqimXI5XsviJWkWf6xH5rlTADuWZe
         aXvw==
X-Forwarded-Encrypted: i=1; AJvYcCXbnfY81qQLZwwssxEuG46V3z+Y2LKAkFCB8Hiix1II8dxesexaPB0Y+n9/wavnHG8VpNr0RiGhiOYCJ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxN55NO2J+X04Q/aIb2JFOBEl4DXF33ZJ8w060Cjfylk6GSblD
	0GvsGgPFczqwsQjG2W4+6eZs72psdTjF/QVeNncfFxknPg+KDv7uadY6aCN7VIoGqWGLZGFvfQh
	CWUTgsC9D0ICD1y1i2iv9f0/oeHNpud8L3a8v
X-Gm-Gg: ASbGncvQTgLIXZgYwQ02gGqv2o50Y0Xkyv0lbvLu+01lmx5OpRNww5i9e+Slbt7dJSn
	8W+XsKxDjrD1lTHVcEvMNh3pVgTqY6yQcY7IXxQB0nqe0Pf1k+FGGQdU1pKVlShz7Z1FBwhL1vI
	QWBr22vD0x5BS/HO6LZMMDr9/O3A26pE+D+pDW8g==
X-Google-Smtp-Source: AGHT+IEMnuR0iRhtphtXv4C1QTHxHM1MIyDPo8Vyt1D9qZ9NHPH4ubF54Q6k9zhNs3EPbgW0cWdG6JTGPvwTNX3KM7g=
X-Received: by 2002:a5d:6dad:0:b0:38d:ae4e:2267 with SMTP id
 ffacd0b85a97d-390ec12f046mr3603491f8f.11.1740762675629; Fri, 28 Feb 2025
 09:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-4-569cc7e8926c@google.com> <Z8HYGTewVatzRJ34@smile.fi.intel.com>
In-Reply-To: <Z8HYGTewVatzRJ34@smile.fi.intel.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 18:11:01 +0100
X-Gm-Features: AQ5f1Jph-NW-kfDiUlg4WnpPXpZgKBTJRy_DkE273cFFp2CxLlC5lP5nC9EVn5g
Message-ID: <CAH5fLgiGb0QrW-Vm2TLHvoCKCy4LiwyrfmMV_oGH0LanTuQHOA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] print: use new #[export] macro for rust_fmt_argument
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 28, 2025 at 12:39:33PM +0000, Alice Ryhl wrote:
> > This moves the rust_fmt_argument function over to use the new #[export]
> > macro, which will verify at compile-time that the function signature
> > matches what is in the header file.
>
> ...
>
> > I'm not sure which header file to put this in. Any advice?
>
> I believe you found the right place.

Thanks for checking!

Alice

