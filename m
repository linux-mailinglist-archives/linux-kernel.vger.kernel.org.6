Return-Path: <linux-kernel+bounces-281597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38394D8A3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB16284AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EDD16B3AB;
	Fri,  9 Aug 2024 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghp2xsTy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961A1684A3;
	Fri,  9 Aug 2024 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241437; cv=none; b=QMCpG1JOvG4bgmQsbFhiFJr9tjlD8o/eueCEJzpLjchcMvOPgtTySVsp04ax1uTBCI2OYxzCgNbf2sdj2RdOVGMv3tYFeQx6UnzFBqPH1YFeQT/z/kNdkuffxmzat7WEQOTh3UcTDY+VCg7Dlo8rFkM/vZlmSkd/reFKexCHpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241437; c=relaxed/simple;
	bh=xTu96gVQQIBkQAzBesrcr+iZgSsTX+f9z99eY96at7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FareJ3MEP1w4ksDGs8gavncNePbGK9JC7j0lC1+eHLDBtD3bnEIyyd+b8qVkQKH95LP9qnGZJMZCvvPBiUdl36K/01xR3C2nDGgrdT+2S2FNZEqA4FOsppoCIqjlOZKEu/4Ok4sKF5FbspNlN3pwGTekUY3rjrFb3r25kCjASzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghp2xsTy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc60c3ead4so20391825ad.0;
        Fri, 09 Aug 2024 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723241435; x=1723846235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbzkV7xxeRVV81QNV7X70uUFN/Mul0WcTbpnujOxo6M=;
        b=ghp2xsTy2GWzah6VjHCwRrsBjykXpNcQP1Z+zIt8uOVPtvfAwizEMSG1YQ0x8EgSyR
         9457BrnHcosFf0QEZXIIpoqyTnZfRMlH2bnVDxPFDbez6Rk84fIgkvgPnDOcvYbFtDAF
         Jyh+3fQKg/ntNjfk2Q/HYxmX/5oAmjDYrNE1ztRLlICCfNCIcyQ397wXWamAuaTlO2Yi
         YsVLyVMhpCW9o1gi0z3UrC1cLoUS/uPFbjaSiD9Hql4qIEoGYWQRFGHyr4mx5VqcsZJV
         +cS2GLu4CpVZzBKfKIf9FHXE9v1eqqr7p7SNKdvhfQZ0QcoTXkbAlEwWjYMNtcSVCATv
         65pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241435; x=1723846235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbzkV7xxeRVV81QNV7X70uUFN/Mul0WcTbpnujOxo6M=;
        b=A8+7mWpsMUjGcjYXuWajEzaafzlLrsB8zqlV7TAQpYx4XsS+Mcn+AKGk4FW5dmFlXp
         NnJ3HxIMs3GakHkjZedt7RmAblz42mjfCJCndRDPZUWBk3e6iTBQhmZTq0s5nRVTDwkQ
         MiRr5XomF0CclocBnxFdo+gwIq1QHHhRVF9L6MSb2dEcTmvNTTJDxnAYQYOdHgNCLILJ
         hmg7rqFiPJNcLfsgDcgC6Litw020Pir8sT8to8T0yN3gT8XQHAaFCdE7mEZJ/KPpDPhD
         zkYXkvpCf8UtjMG/2WpTckL7wm1HMbJc3p/rhlbadAvDs66vGhMAZvOAIr+Ql3aiuSst
         ijsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeBWelQQzD2pPOhGgQCcuVUB3WTUTOy4A+iFDCuSwxvU5eDAL8xdrAs1gI9IQkQw8+Yj83qJwCm2ROXhyy0t8kQMdvgZTDdKJUUoudJ8f9gA/215ZHUrFsfRp/fL7zfm/qzEGA1DR2n9p6h0Y=
X-Gm-Message-State: AOJu0YwzrVZdAJGUrHBt98lVUdPqsXUs+2TfWPHqyDOhWEafkkqcusn3
	QSX0Ot5m0r+xunhWURRJuWw8m05EduYkV+xR7Tl++Ugr+ENWRZOQFx8o4qupMB9DQXg8vNpp2vk
	n7z9A8t7rqJIXTlYqisPaxNw614o=
X-Google-Smtp-Source: AGHT+IGgYkQr+MjS1MO5T+I/pnZfPga7tHNHKQpH9oOqar6JGxzbYKJJ3wD/ZViolCQTXbW9ZXLpRZtda0elVbgGs2o=
X-Received: by 2002:a17:90b:384c:b0:2cd:3445:f87b with SMTP id
 98e67ed59e1d1-2d1e80604a8mr3034755a91.29.1723241435433; Fri, 09 Aug 2024
 15:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806150619.192882-1-ojeda@kernel.org>
In-Reply-To: <20240806150619.192882-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Aug 2024 00:10:23 +0200
Message-ID: <CANiq72=oimd=7wL9_Dfy2+yEwcW9MKQ54dAHAm0TxoRVajPS=A@mail.gmail.com>
Subject: Re: [PATCH] rust: add intrinsics to fix `-Os` builds
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
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

Applied to `rust-fixes` -- thanks everyone!

    [ Trevor quickly submitted a fix to upstream Rust [2] that has already
      been merged, to be released in Rust 1.82.0 (2024-10-17). - Miguel ]

    [ Shortened Zulip link. - Miguel ]

Cheers,
Miguel

