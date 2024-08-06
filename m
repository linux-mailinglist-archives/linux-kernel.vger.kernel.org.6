Return-Path: <linux-kernel+bounces-276508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DDE9494BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB671F2305C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5938F91;
	Tue,  6 Aug 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gF0zgAFx"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB42C6A3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958933; cv=none; b=aNKnZ5BJpQNYuC48IOxdp6YUeYfEqZFwGyN088KPrRFGgA6sGVQZrjllZnxF/IhBU1396vzF6+SlzdjyFGzpyTELX8H3bWEhdsmPmF00Ywx5S4P4NJy8iHLxCnDP2YL4zbA5eHu8+WnT82hEq1PDs8NTxNHH5gvOVGG+7Sc0b9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958933; c=relaxed/simple;
	bh=2F97gembZB7Ph+t8UMlLUN/RaEUIDWcSTRDhoreN85k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejYg2vZqeQ/lo58L86m8nGICwf6uWtnvyoQzJmcjKE+dEYuay5Sybk05/jSlnbcMgbnLk+mnVKkVeV/WEo3kCyGScntZmzXzZIrWmh12aBPuHxVWJWugGZfmKmuNuJsevOo78+nTHcQmg87TPYcWNZ/ZmFVLLfZtqAc31reWow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gF0zgAFx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3684bea9728so450266f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722958930; x=1723563730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THccCsa9d44/a7k4O9weE7Ak3VSX2fq1wLCNhXJEyK4=;
        b=gF0zgAFxz4+lyXxqmdcJ9DIETmodb9nwyfmVSw6EKIX+GwPLP3UYEJUwGTab3mxJAz
         23uXBSz3geC0U/gzV1GiAcTend95GCJlXup39W2Yphi2d1rydc6AuHfbVzkTeJ8aUC/L
         5WL9Ry3ywy/tDzsKmoue7HlXxW3eo6od4UNIyoHMUPo8fjr0CBjoj+Ns6LcPbXgtqjJl
         rVsOHtJ6T4afw1MZ40Dm3unSj1JLD2X4cNZHBhSTw9QB2d5TJxr9CsHAgUvHKWjY28v3
         IKcNMee9UJcJLwFeh/KXJa7LosU2nXRWrA9L1XdCKZ33Mt03Bys/uCsp/2y/YBM5bzO6
         mD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958930; x=1723563730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THccCsa9d44/a7k4O9weE7Ak3VSX2fq1wLCNhXJEyK4=;
        b=p6gDeZ1CoVbb6LN4jYjwMJGrQEaSO5xxMioaP1CD7ye/H9ZdH1KrbGvSbYBKdJptZv
         pfueT/DxQmKV2bCM3NwmdfzbGqut5/D/3ubzPWNyxoxkM4GcV6CEz9LPKqE6YlYlMuF5
         udHmFsj1GIKUJLZx3X8mLb1UEI0eC0heF+6/A5fgqMp9MCMDW+VHbPfYyxihn7ZVhAhZ
         6rj1jynMaMkLt9wrJD5y8bc75pLUhbf0skSBMmiXeEIJaRdgr7fJMI4ggYkpiYWLpsAX
         I/INbTPyp/jWy6VFKfmyJ35GZDtItSyt7Ivs/qu8w46qnRipeJx/fcCj6vgU9UxQ1Hso
         H4aA==
X-Forwarded-Encrypted: i=1; AJvYcCXgZIDp5ev7vbemN37KWPYV53snnSjP9NpoYf4+8Jg5v5cHECxWI7lMAcL+7auTKR0BJDV88CvMBI0qupU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09GEg8ZhoFnVEfaThY4VBiXmelWEI8PhGD/MDD2/YbeMEDDNU
	EUnylJ8mUko6LA6fztApYGqhYFDdhw0fFRxn4d7jGyOqTtrV0jRYBHNwUUIdX2utzYl6bhaK8of
	gaMqu92/6YgTmLE5tzGdzozDwOK+2MlPUijch
X-Google-Smtp-Source: AGHT+IFy1q1xSU6pQqfOY13ZKc31YixugPXTYoG2iOCjOHiY5xXt+yoxINs0iVcTVHkdmSjbDCF8Z08VAJ3+o8YTt88=
X-Received: by 2002:a5d:67d0:0:b0:360:7c4b:58c3 with SMTP id
 ffacd0b85a97d-36bbc17ec0emr11080309f8f.54.1722958929954; Tue, 06 Aug 2024
 08:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806150619.192882-1-ojeda@kernel.org>
In-Reply-To: <20240806150619.192882-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 6 Aug 2024 17:41:57 +0200
Message-ID: <CAH5fLgiPS9ByFPU+4GoLUwgH=GTD0xkCp2mi9zvaC6XzLpP03g@mail.gmail.com>
Subject: Re: [PATCH] rust: add intrinsics to fix `-Os` builds
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:06=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Alice reported [1] that an arm64 build failed with:
>
>     ld.lld: error: undefined symbol: __extendsfdf2
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
>
>     ld.lld: error: undefined symbol: __truncdfsf2
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
>
> Rust 1.80.0 or later together with `CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy`
> is what triggers it.
>
> In addition, x86_64 builds also fail the same way.
>
> Similarly, compiling with Rust 1.82.0 (currently in nightly) makes
> another one appear, possibly due to the LLVM 19 upgrade there:
>
>     ld.lld: error: undefined symbol: __eqdf2
>     >>> referenced by core.20495ea57a9f069d-cgu.0
>     >>>               rust/core.o:(<f64>::next_up) in archive vmlinux.a
>     >>> referenced by core.20495ea57a9f069d-cgu.0
>     >>>               rust/core.o:(<f64>::next_down) in archive vmlinux.a
>
> Gary adds [1]:
>
> > Usually the fix on rustc side is to mark those functions as `#[inline]`
> >
> > All of {midpoint,next_up,next_down} are indeed unstable functions not
> > marked as inline...
>
> Fix all those by adding those intrinsics to our usual workaround.
>
> Cc: Gary Guo <gary@garyguo.net>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Genera=
l/topic/v6.2E11-rc1.20doesn't.20build.20for.20arm64/near/455637364
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

This fixes the issue I ran into.

Tested-by: Alice Ryhl <aliceryhl@google.com>

