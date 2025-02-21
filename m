Return-Path: <linux-kernel+bounces-526336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D623A3FD78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5F03BFFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9C2500CE;
	Fri, 21 Feb 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLhkWS40"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F42505B3;
	Fri, 21 Feb 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158655; cv=none; b=YikKHDEVjDxrPLh4gyRm3+qxiIrYowRqlMdh4oPD+Zj9VgadJCbChxIzUSrc8AQuMNy4MiHFHHsttkGLQcqtS0almr4sQ7B99zmtuHlwRQx1J3NJHwuwBoX0O0CL2F2/txV1mdEsmLGAa6u8Lq8WqShYn2OOassfhNyF6yVN1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158655; c=relaxed/simple;
	bh=2EjyR+g7vRZUBWxF+lGXtUmh2U+J7Xrsy5zEPm+IZzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqIG+fnba6K4hvlSneqWeOAOtE1+THi5vnFWcfAA4Ibr6Dsxzi6Svq9DaBMsk9cm29+feGHpjn6iuSiC+5++7zjRqBdC6cag2uK1n730ZoGc7jCfPeaPlzUgSDl+yXtEeF0Q7crPAKL9KmKS72Eu6ZqK0D3fFwL8/z+kkjiQ730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLhkWS40; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-309311e7b39so21505521fa.2;
        Fri, 21 Feb 2025 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740158652; x=1740763452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EjyR+g7vRZUBWxF+lGXtUmh2U+J7Xrsy5zEPm+IZzo=;
        b=BLhkWS40qcp3pNp9ugMj5y7bbQ6vxleUil+cSxXWtuLpuqeeT/9W20iUaF7cHxcufv
         X5JDlg7l7NwLeUFabmqJK82LFS/KvltrxmR0POC8qrqDe1XgfsSMFizXjKhGrz42yfbL
         fj+2Zc2KYbXS/018Um2Nm7359ltZ7UZP3K3MLqwUpehy3v/tAkLz2KVdt5ZDjD3mypEn
         6POF0yiYk6yw9GHfk5POoNDbzRJRzVwxz/XSS+8i+laE+EKgn2CJtGIDoB7AePhb1d+L
         JDHXWserlRO2gz4fo9fLC5kzG5meI8X2EP4+RDt3gTjNpR1V4Cc22qckyXWFIQLFljcn
         ZO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158652; x=1740763452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EjyR+g7vRZUBWxF+lGXtUmh2U+J7Xrsy5zEPm+IZzo=;
        b=GRGMRcuKm5KHM7cUM1dqGFqXouMCw2iNr9Bhh2eaT7iQessKkdKP0/1etUxOBF/hIO
         bMpt9jpwFzbo8j3wduWD0/vj4CDMMfColQ+5uK3GWZ+SK6h5dx9QzKZJENxru6v6Mnix
         UQU57o8JP5qrFrPJx/Rjbzygh60VQLZpglscJBFnQj5fkxAvcHsyEEPWGakHvNBeDvb6
         mUjk/e0/T51eMxPwEU1oD1xAHcpAE+mW5lQqvqc+CbUdHuzdiU6bhJGsBq2zzqK7LqKh
         T5nXM9ucafFTNgfNyzSqM0nLWdCS1+VBUX49FFFwRqpzOTLdgEWEjOIDjyct9pOotm97
         BM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5GOTqCyhDqS3y8fpzWO/jKONEhxPqtG+aMvOmlAcR9fbVrOhK6tR3dgjx5wORFA0Nof+Nz4OY/ayP5kYlBeI=@vger.kernel.org, AJvYcCXDo9e8xeOMW48vMTAngHWsygA2AbrHG5kD5WFtg8q3e8PtdGV7IeK7tJCGpcvBjSqCz/ujmmM99U1o/8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5/wx+r2Es2L3PGTMWK/GNipDnp9ekyaVXA6RCtA2U0fSyvx5
	WOwJuFyd3LsIN+hM/3sP6IQpX3FKH4gsVzwlg3kkN+BqcJ3/A4TmkDiHgY0IAIJur3zxAztjfRE
	eqyyaHOaE5hlWCUi/6+Z0RivJ4jI=
X-Gm-Gg: ASbGncsAS2B/SLiv6Ftc1/OUluQKf2TZQNER1/J4zabVp0T3lx87kYk3igdnzMLyICP
	Uz73ArQSfykGc2cyjPYktlCwZ3KZRGnL5gdycO155/DLizs6uOiKVRlyxEEc8JhdHaCqayTjKyY
	nw2vf1hZf3kPhyFS5FADAvb7em6hEDai8fivTnAnsHSw==
X-Google-Smtp-Source: AGHT+IEp8rrvSYmjNAvraGTifvHZQppcmyKoqsX5TObi9sWl16VERgT2hLqgLNff7Cp/bA7YqR3AVd8y3ovuZ44a7pU=
X-Received: by 2002:a2e:9d93:0:b0:308:fd11:7700 with SMTP id
 38308e7fff4ca-30a598ebd5amr16587101fa.20.1740158651552; Fri, 21 Feb 2025
 09:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-2-gary@garyguo.net>
 <CAJ-ks9=b5Mw1kQf3xz_VPtp4CkUhw=6xQ-543uXkFgn6wUaOcQ@mail.gmail.com> <20250221160217.2a6772c3@eugeo>
In-Reply-To: <20250221160217.2a6772c3@eugeo>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 12:23:35 -0500
X-Gm-Features: AWEUYZk6KqbIOuuM1Y8gLv3h4Q4LV2CufXNDuvVeTuzN3gikZ2xh9iDiHEH4Jn0
Message-ID: <CAJ-ks9mtKNzJhUaqJz=VZsvPhF8xaRc+C5eMjHhA9CCqd74DXw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: implement `kernel::sync::Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Lyude Paul <lyude@redhat.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:02=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> I think you're referring to refcount_sub_and_test? This is
> refcount_dec_and_test.

You're right, my mistake.

