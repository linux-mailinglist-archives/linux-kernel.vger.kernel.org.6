Return-Path: <linux-kernel+bounces-348188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B607B98E3D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CC5B23E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36229216A39;
	Wed,  2 Oct 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQX3n/GI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B32216A37
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899366; cv=none; b=bEJ+C00ok6Mw+esl+02abNpgiJu/ZuThrkZWgBnAQJ/gJ2nO+wNK4rBlOtIVnV6GLnotQxRiIxZoqSzPHnEPPZxMkzYA1Uz7uPRRXJUiyCSFKcxEZYC6jqQO5ejyehkqX/WzoGdqqt9aJL4+dhRPXfQyOfsdrH5bD3g/ci42uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899366; c=relaxed/simple;
	bh=QxE6XFKme+xoxU1Rszza7HxCxfUttwEhnIGpZd9XnTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPIK7E9zjgSUl6dheIqdWR/ClnF2Oj3GAYUocv4rpU7Ub07Nij66WznDEvoNtzbPAu046FopZDDSgKqkiLfSH59q4+U/q929t/FHVhWgP2OP0muYzZkqpBuqwP8JTV0rGQXpi+XCZnWFdTKCtTopIoNNhoCQwncN3A/HowyzGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQX3n/GI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cdac05af9so198082f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727899363; x=1728504163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxE6XFKme+xoxU1Rszza7HxCxfUttwEhnIGpZd9XnTo=;
        b=yQX3n/GIwXicZ6pkA13gZgbJ0Ql0sWbk/mzZYtNeolGBCpyGZ+Z2CpNtwSlvJjMJhZ
         TKehQV0Z7Az8iii3YsY6y3xWjGCGd6zAn9xLgdkp3LzNOX3IKGptdfKBIMsAYgAMlDrs
         lOuAPDJagX5gOSRpo/kXyRteVyxwNXmFRGtXLFZwZZxEmvd1cHjNo6pS31n9qA9OHTmt
         2qoy5EMJC2J9+W0wZgMhb97EXoz8L6FjYD+mNy/jL8JkH9tqzc0WfRbrWIOSKCcvEnMa
         qoH7g0lPcIQUDWNw6qjTHSVHudZqNWiRTLq2gW7DCtWQGqZ7PLU1dqCgTXy4yj2vjzMU
         mYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899363; x=1728504163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxE6XFKme+xoxU1Rszza7HxCxfUttwEhnIGpZd9XnTo=;
        b=eCJHNoeGdswPr1pftt0UHP7mbR9poRX4D3MY2hXdfLa7MXLI9n4vml5Ja3TUh86GEK
         oAV5P7SxsicvNDo5fSVedsyE9SNG0AL4Ibv1RuxRIfwsUMNA8Qeu5d/d3X05Dhtxqjgg
         f8JJ748FshIYR9RA0U6fOmWxvpyZCFRdxw7lTgjswrJ48IrxS9qeQjt8oEZd+L/tRV3r
         i8CwDhMzGEi2nhzMx2fwDA3Rkgj/cLgo8CEy8SJpaiVAK9iQyepc4qQ4eMDrOGwwy6EU
         UBL6Wl5Ye0JK/9JYORXriOi134+pwYLC+taXVFgFimF+pCwDBcnrhwjMI+ZLLdOR3wud
         8Flw==
X-Forwarded-Encrypted: i=1; AJvYcCUjqG+g58Xo1Dh1cgTmpbi1hNrg8mQp/MBQCZ6V8M39ZJebMS3evLpAiEKh7h+fkh5e3yTArnCYFwTBw/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1njlsmbZZsgcW+L0GyAquYvfXlbactX7kOs+wc+tb5TcpsTN
	GCTRoKWltkp2lXzhEpSPfOPJK+l+xsX1twlCh6NtPXjdUihEB2DVAzfYRhJSj4ZYS/BuEV4R5Sy
	v784EHHyhwy3jpZc49yCuGsmvwlp5azlKUxmL
X-Google-Smtp-Source: AGHT+IFdAQHigHgRwqbBluWiPNLhOqlEtdJgsEEyQLh5TI1zvrczhPyhqF49gn7+lx+aW6IN0h4DED7pVuEkReeGskU=
X-Received: by 2002:a5d:5d81:0:b0:37c:fbf8:fc4 with SMTP id
 ffacd0b85a97d-37cfbf8110amr3030581f8f.59.1727899362994; Wed, 02 Oct 2024
 13:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915132734.1653004-1-gary@garyguo.net>
In-Reply-To: <20240915132734.1653004-1-gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 22:02:30 +0200
Message-ID: <CAH5fLgihaSVg+=D_BfMxnt8VBO-r5LB4akus7EMvAfOyNv45FQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: enable arbitrary_self_types and remove `Receiver`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Danilo Krummrich <dakr@redhat.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Alex Mantel <alexmantel93@mailbox.org>, Adrian Taylor <ade@hohum.me.uk>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 3:29=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> The term "receiver" means that a type can be used as the type of `self`,
> and thus enables method call syntax `foo.bar()` instead of
> `Foo::bar(foo)`. Stable Rust as of today (1.81) enables a limited
> selection of types (primitives and types in std, e.g. `Box` and `Arc`)
> to be used as receivers, while custom types cannot.
>
> We want the kernel `Arc` type to have the same functionality as the Rust
> std `Arc`, so we use the `Receiver` trait (gated behind `receiver_trait`
> unstable feature) to gain the functionality.
>
> The `arbitrary_self_types` RFC [1] (tracking issue [2]) is accepted and
> it will allow all types that implement a new `Receiver` trait (different
> from today's unstable trait) to be used as receivers. This trait will be
> automatically implemented for all `Deref` types, which include our `Arc`
> type, so we no longer have to opt-in to be used as receiver. To prepare
> us for the change, remove the `Receiver` implementation and the
> associated feature. To still allow `Arc` and others to be used as method
> receivers, turn on `arbitrary_self_types` feature instead.
>
> This feature gate is introduced in 1.23.0. It used to enable both
> `Deref` types and raw pointer types to be used as receivers, but the
> latter is now split into a different feature gate in Rust 1.83 nightly.
> We do not need receivers on raw pointers so this change would not affect
> us and usage of `arbitrary_self_types` feature would work for all Rust
> versions that we support (>=3D1.78).
>
> Cc: Adrian Taylor <ade@hohum.me.uk>
> Link: https://github.com/rust-lang/rfcs/pull/3519 [1]
> Link: https://github.com/rust-lang/rust/issues/44874 [2]
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

