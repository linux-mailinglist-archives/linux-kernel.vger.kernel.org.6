Return-Path: <linux-kernel+bounces-346723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8AE98C7F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B6F1F24EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8CF1CEAD0;
	Tue,  1 Oct 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfyqjRJI"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83ED1CCEE5;
	Tue,  1 Oct 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727820755; cv=none; b=sKZ3Wmnf7WG9SsjWJauxz+YR39+3Zj4of+nu/+OebK9n++4VSPaADSnL/uI3rw7B+cP3aB5ds/55KlNq3PVcHsJcN0h8GXax/xScDfbLgMr/jU5axo7e2GQnEycB3u7aayVv2+NAOZZDVmiRo2TuuydsaLO9UoaqAauCRZDOPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727820755; c=relaxed/simple;
	bh=+Y4UDQ0SBLFXK+EKaoLuBpz9TvjY4PQlfPV4NBauuBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFYYDu5Fl15QB9eUHV7JhSHq63mnbZnbwjyCl4ZeikjwG/obacEanZbL1X5s88276ieHpdWChcmWm8jM/tBBqWiauDxW35T4/liFXFNFww9P7yCMo8SHOigIOJPklv9LHQAGKvEqdhFODWcC/BJ3gZI2ESP1pKNBmBq6g1R2ULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfyqjRJI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e0421143so875275b3a.0;
        Tue, 01 Oct 2024 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727820753; x=1728425553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Frfh6hBj6DUTGEMrubT/n9jUTuny2AERvO+Dq7ZfqEA=;
        b=TfyqjRJIXZBi4w3A8i6LelPObBJwzQhqhUJ825zj5XvOhEQGBFcVlm/+NLroZAfkFj
         HwsKSvsX5bn6cEylZlHsHNEiMqD7Odg90yht3Fh3pfErCUeXxUdBoLds2qzOSjmO30/x
         tg2zc/nxFmDFXiSxSCgKq4Q9eiWymIO9C8TYGLC5X4EbMXlQu3DRzstcvfy8cK/1GkKu
         LUu7vimKTm6iSBVGPLrzufrgAxARvZj1D3TCdXiRe9ALzBS/zO45cItF6EC5JqElsdFH
         Xo0oE9lgPXEzZAVFMYyMSc7VNO3tZmlGCe20Pjj8cJytDHobTPQJJOIyFUmyWAcKs5kQ
         mmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727820753; x=1728425553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frfh6hBj6DUTGEMrubT/n9jUTuny2AERvO+Dq7ZfqEA=;
        b=jdgQjbSezM8UFcUgz9cnL/E4fp7vn2Qlkb4K4YeIrFF3bzL6/b7EWiXoVJ5+jxiYCn
         DI5CwGO2cjTGq8mglqL/42MEozeW+7wVL7ILD8LMzHFzzAYPsp1oKG0NyLZCMYQVEre3
         IrPo1lWtdxWo/6G5e1+Hz2qW8AK9UXzCsRPuyTKiNxVkMkRhnwa7kfLvuNaBAA2BRdE1
         YBMITLSy1gOt/LcSs87nn2jD/do+9kvqNmbyUFP0IZO9PauZTCKZUk6vqC/lylfqSAtX
         9n4Tyydq0e7IALXFth45LouLXVEicKe3lacw9EVDePGnwRSm22aaYHzIJpcsb4Wy27WX
         fqWw==
X-Forwarded-Encrypted: i=1; AJvYcCVDMth9HLen0mi64lkNriSU8pxEa2TxPJw3Wld+qrkEfjMtGhsS/Jhqn/bpEWaeKIH6s7i8gaN5xdegbIA=@vger.kernel.org, AJvYcCX0Kob7z/MGXvzBHKFlVqdgMSuq5L+t5bvqVwVeG6Awr4QWYO5hNyxANZwZ77lF2+uhrooduo9Qi7TpqNlkHqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylts7fwOX0pVCG/K0aqT73EKPNb8Z3rdY+j42tCUcPmnFMU7hu
	yDRyd529ufCC7ptqAXyfWLkJEsIcGMsIrxDWMClOweiiP9MyAPUfep+rlhKrlg8U3CPTAo2Xv3f
	KWI670Ok9MDCAnjJUdrv0FqjJlwU=
X-Google-Smtp-Source: AGHT+IHSa0R4OQIO3Y/6fLRRBq/Xo5ODccew70DFb/Dr7Z1Sg3pF8k4ffLa067F2mmhJkkeuuAW91uzXNwCGzvJB800=
X-Received: by 2002:a05:6a00:23c9:b0:718:e49f:246e with SMTP id
 d2e1a72fcca58-71dc5d5cce5mr771264b3a.6.1727820752956; Tue, 01 Oct 2024
 15:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927164414.560906-1-ojeda@kernel.org>
In-Reply-To: <20240927164414.560906-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 00:12:20 +0200
Message-ID: <CANiq72k7ttdioXrto8VRJL+q2F9EjuPxhOR9HgpwdM+ZySM_+g@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: use C-string literals to clean warning
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 6:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with upstream Rust commit a5e3a3f9b6bd ("move
> `manual_c_str_literals` to complexity"), to be released in Rust 1.83.0
> [1], Clippy now warns on `manual_c_str_literals` by default, e.g.:
>
>     error: manually constructing a nul-terminated string
>       --> rust/kernel/kunit.rs:21:13
>        |
>     21 |             b"\x013%pA\0".as_ptr() as _,
>        |             ^^^^^^^^^^^^^ help: use a `c""` literal: `c"\x013%pA=
"`
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/master/index.html#manual_c_str_literals
>        =3D note: `-D clippy::manual-c-str-literals` implied by `-D warnin=
gs`
>        =3D help: to override `-D warnings` add `#[allow(clippy::manual_c_=
str_literals)]`
>
> Apply the suggestion to clean up the warnings.
>
> Link: https://github.com/rust-lang/rust-clippy/pull/13263 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

