Return-Path: <linux-kernel+bounces-245369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582092B1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B844B222C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA4152E0F;
	Tue,  9 Jul 2024 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8XqFns4"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A657152515;
	Tue,  9 Jul 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512165; cv=none; b=JLdN3yjcmCnURbiHuMp+X2qEP4SQuH65Vc7EgjTsoyYuWKmuMQpIXxA3CJtOQlhBCOtXPgpjce2KwfRcMlSGxOh1GVlpfuO5rjA36EPA966Zy9RaHKbi0niLUArFyN5n9MpYkao+WebyRybviv2QAOEI679mAprpdfHr2sx9qzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512165; c=relaxed/simple;
	bh=+vBaRI03edLB5xWMveAjscYshlkoOpIt+pkMK8Ze/QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U82mshogCHHqav5OeTXjUHO3cPxtY1tsErMbM5WIqP9vBCKXzt+JUVqW9zJdFBp9cWllUQFrkWnSR/zS73EcDQi5y0BQOktI6C34hjXW3RW06QbZAr6I7Mkm5owxd30NhOoONnsKU6CqGUAM7QINkQ5YAdMScPpMd4PcSubftW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8XqFns4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7611b6a617cso2924282a12.3;
        Tue, 09 Jul 2024 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720512164; x=1721116964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saVEdMntiEIairw273nwNBQX/lPMGFlUAdIrJqbTXIM=;
        b=N8XqFns4WVOAxPvPHsOWOaftWP+4LDZqd+EmfZ5ERGmrtpfm42fJ25rcqY/UWpZlvT
         Ze30UC8G6+HPIQt64+H0vM8Ueb4w+2hDpFzRCvb0vQGww3q9vcjfHrqa5+q6uwWektTY
         AeKzXqXr7mn+opCYWZ5SKkbHtqmnGzcVnIdQxRahUQ8VKgVywKZ/dneHKN96VTE44Mr2
         4l00M8/pb0u2O9/zhIhUFVLQKRY/JbcLtUp9S8DIEkEJTIJLtnQ9/a0SepHShh6ddrCG
         zjS+2njiquFjoNN+roFrNnVqmuUQfk5UULeYjEYkYiQngKyjL5f2sppTm56jvvUMr5L0
         GKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720512164; x=1721116964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saVEdMntiEIairw273nwNBQX/lPMGFlUAdIrJqbTXIM=;
        b=sH8tWn+37ML7x9HGUtJric7Cv1HVrO4bppmVb2Zk+leDFYGv1xr1ZIAaG8J2vvohlD
         bruGpeSi/aFsI0WOXpCz+x8uhAhtTVsBe4L2/jyUdgTXbjDA+eQRLy+hxoVrxLoX08UC
         jG4DRQlbhcG91MNqwpJlPgP902eB+ULM4GAeAuVyhXvRjjlWr2wFspyg8qQmESW4AFUf
         PIsTM5aqTYIS6TqNA00dKVExr/9psEEN/LKq23oo7k4Weo9mJQyuZ2eWwFc1VqcZ7IRO
         tZJW7OLEDln87AOQhiDhwVQDJ31HBA2RSL83ummVSnOZtMciJNVrOLc6xJ5JWhUUFvpt
         K/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUsmDvwbRi6nffM4TgRqwN7AIoGJwO4M2utI4a5h12YM8VasbniqdaoxPSnscS1dPSOO5LtBJkhDjnEZWKWyMjCzQOscqaJ4wj453CLXY5tookibyCICTg2oc/YmG0jDKaqoZFjyhdlV1uQtE=
X-Gm-Message-State: AOJu0Yw83jf/IO43/awIVc/dUVkAZsESaNZxjjGeaMnoP7a5ce234ajP
	FrtOW4rW1JUjpw4bvpsCQUGjdtblTft4X7aQwWCK9pKKqWwaxDAHOwYIBigJfCIJndTXrOCXnaY
	+VyyAKgJ45e+0Ep+q9wskB3NY+UU=
X-Google-Smtp-Source: AGHT+IEPaWXpA6bmFKESHiOBiuFGzYAxm69W6WWM8L1uIfwQ+XFOV2DF++TdJgb0DyDbfC7rvCdAhc7gcrok6IqEFcA=
X-Received: by 2002:a05:6a20:e609:b0:1c2:8e3f:a5c with SMTP id
 adf61e73a8af0-1c29825044emr1612336637.35.1720512163784; Tue, 09 Jul 2024
 01:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
In-Reply-To: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 10:02:32 +0200
Message-ID: <CANiq72ka=tMDHq3S2N0dkzj0DBje+kdz0nFtaQZ9RHC0rbii0g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Memory management patches needed by Rust Binder
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 4:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This patchset contains some abstractions needed by the Rust
> implementation of the Binder driver for passing data between userspace,
> kernelspace, and directly into other processes.
>
> These abstractions do not exactly match what was included in the Rust
> Binder RFC - I have made various improvements and simplifications since
> then. Nonetheless, please see the Rust Binder RFC [1] to get an
> understanding for how this will be used:
>
> Users of "rust: add userspace pointers"
>      and "rust: add typed accessors for userspace pointers":
>         rust_binder: add binderfs support to Rust binder
>         rust_binder: add threading support
>         rust_binder: add nodes and context managers
>         rust_binder: add oneway transactions
>         rust_binder: add death notifications
>         rust_binder: send nodes in transactions
>         rust_binder: add BINDER_TYPE_PTR support
>         rust_binder: add BINDER_TYPE_FDA support
>         rust_binder: add process freezing
>
> Users of "rust: add abstraction for `struct page`":
>         rust_binder: add oneway transactions
>         rust_binder: add vma shrinker
>
> Links: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-0=
8ba9197f637@google.com/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

[ Wrapped docs to 100 and added a few intra-doc links. - Miguel ]
[ Fixed typos and added a few intra-doc links. - Miguel ]

Cheers,
Miguel

