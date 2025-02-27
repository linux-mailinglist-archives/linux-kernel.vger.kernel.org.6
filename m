Return-Path: <linux-kernel+bounces-537463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF8A48C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373D916D145
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85823E34E;
	Thu, 27 Feb 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhUyCRuL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A377277811
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697297; cv=none; b=TU+Zrromq4CZiQpPCje7v1QO8sod7tXDgb/a8qlY+igfRX5tB7uD120Zm1PX0GpMU007kTtKSFdIhLzYD/Oe5xuXZXGeceFXUe2zq1ck82mK9pj+sb4pL7o7uherdmY+tmVtXRrv4v8fC2nFoy87z7Wpgsy2mlRaEwA/PmikxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697297; c=relaxed/simple;
	bh=T/KXETJ0TFWxdMyVLabvOPEG48vmilHHA1hKIy0LJBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZAdp60d58h+zIO6FbbQLjU8h18p+vCmsc0O7Qx6Kqs/WGVa6mpPXi/63NP2addCNxUPF+jg5DEnp+zR+AHtMx3YF8Tn2OUKfOyE4jbOKB6XnZmLOh/Y7/X4FxP7RifmP8Ne4VCa2HNp/T15PaqXscHskGLLFmvjmFSWAGipV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhUyCRuL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so1739279f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740697294; x=1741302094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/KXETJ0TFWxdMyVLabvOPEG48vmilHHA1hKIy0LJBc=;
        b=vhUyCRuLR09clL9cJVZ5pqRJNokVvM+wExR2XF583FE/Dm+2YKXm20sWOGp7e5O4Zh
         69C4UPi4doikpgCx4KBvOGbjH4lh4GE4mS6aEoaA4b136QsDEemtyjsNkPZqXiEVkvj1
         OR2RXmxDybInuqZBM/q8JsBiLZ3zOKahmJnEOhppiLqSLb4iwVVs6pc64+Ectnk+SZIG
         Ej6TKHij/lqDL82iJoK0Z57IF+6teqFzAgsTs75HeGjCNzW6YihjPLnQ+r8w5Ky1a4jI
         Sfs5LfS6b5yLJO12Lc/TFvOWlWmftaqRrQRu9DsqJgf7wkWY6Ng+A6wiH5jl+6Izs94M
         SCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697294; x=1741302094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/KXETJ0TFWxdMyVLabvOPEG48vmilHHA1hKIy0LJBc=;
        b=SrcDpm4suB9I5p1O6kQjg1/ZW8fT6mT3ucVP9G+SMEomOTc9vb5Q6iSQadF8/lnIfD
         NQeUguWbKGmg7IkYTBMcWOmy2NBTvXksmnHucDTAGzhUFxVH+l4NEF3WIoSR459lUpIN
         13ja1c8MZARHY4mx3/LEiOekAAB6Ft0SDDZDNmPBIB1vZmgR61ApmRpamK6munOUHw5F
         /R7mV1OxBQUZL4L2JAMJz4XeHoWoEppsSYDiBy/kwN3y2xoRMbKdqHXuzBxFx9uTZOIj
         T8xSeRrcnWwfqM6n/1rn4SQE8aqz89mF0rFoYodwZErE2GEVWeu0EaUuTeMWiAMMepe1
         kXjw==
X-Forwarded-Encrypted: i=1; AJvYcCXkMNhcYqkM1nOgi3MtiETjDlZtMHyOVYCyRBdDu+72mBzSDYLFCwTarojJC9rjL0OxD20bSbSwvPS9p28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMYiKHqsIDl2gFubBZ1mVgPoGtFANO+hTHtfJZKPJQ83YlBVr
	hxJ98GQ6dXgFi9xRN1epNL7b/URAl7ZkFmOdmFaUtpHpq2x0YzAZ9M/xl9V12Tt+BZOE/Spn/IL
	9Py3G0cIPZs4yVESGxE0DNsvAwjhlmPz9Qf+O
X-Gm-Gg: ASbGnctTW14WNnaNZtzyuIJVcCZPNkrqTGR3GIDtLEeJVoNKH3CZgPv0E2q/4DCg+dM
	kj2Q6Qo0tIHFQd/WKRX0bhhKpqIAS38D0b4ea45a2Znz8mROkILZMJ7DtWE/mth5wYj/j1etq6+
	nNdkJ3UY+i
X-Google-Smtp-Source: AGHT+IEUTU0KblbuQlyHGcIr54A0QbBhcS2oujT2neK736LGyvJHYwON23tG1rKqrRjcL4V5ye5JFgYZaKYHem62dEg=
X-Received: by 2002:a05:6000:4c6:b0:38d:c44a:a64b with SMTP id
 ffacd0b85a97d-390eca2589amr634869f8f.48.1740697294171; Thu, 27 Feb 2025
 15:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
 <20250227-export-macro-v1-4-948775fc37aa@google.com> <Z8DZEPoTJRwYj0p3@boqun-archlinux>
In-Reply-To: <Z8DZEPoTJRwYj0p3@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 00:01:22 +0100
X-Gm-Features: AQ5f1Joq_xPPPjbC654zyWyFJjBzyt9Fu0LwYPzYOhRY-ceZYmiJ6D8fWyhkRCQ
Message-ID: <CAH5fLghEiHmDABQNNCNr6czDyL4Cis60zxM6aFo+9CdqqSjsJQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] panic_qr: use new #[export] macro
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:29=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Thu, Feb 27, 2025 at 05:02:02PM +0000, Alice Ryhl wrote:
> > This validates at compile time that the signatures match what is in the
> > header file. It highlights one annoyance with the compile-time check,
> > which is that it can only be used with functions marked unsafe.
> >
> > If the function is not unsafe, then this error is emitted:
> >
> > error[E0308]: `if` and `else` have incompatible types
>
> Is there a way to improve this error message? I vaguely remember there
> are ways to do customized error message.

The if/else error message is super nice because it shows the two types
next to each other where it's very easy to read the signatures and
spot the difference. But if you want to investigate other constructs
that potentially have better error messages, feel free. I'm happy to
update if you find a better construct.

Alice

