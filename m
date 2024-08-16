Return-Path: <linux-kernel+bounces-290325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80E955240
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A081C215EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47121C4635;
	Fri, 16 Aug 2024 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/nTHonR"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642413B293;
	Fri, 16 Aug 2024 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842697; cv=none; b=e3mHJIC1SvkSd1AwQwiEPoacYVP60LMp48yL9sYvhlok+4El+bI2GBzo60fNeTtuAGhdfsMDib1Ar5p431jqwGpsopx8B415kL9mwTqQfWu/vsxVz5TXJC9RjADad8Is7GDI1R0V44N7WegH1GnH96E1vNabqz+zJKUu32aYCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842697; c=relaxed/simple;
	bh=T68BK8/ZLf+KT+zFv9yqVj8/Tite2DTE9V8y2JPHTlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovk4N9bqV+KRUpCRsY0EOjSkYBMl/vBPj1Ry0eHgHgRJa0LHOA0w4r5y4JhTPW0nMywawtMWkQpbw9Ll6HcGgogN6U6YpMfoX5qzuY25jNry9OMBXdsiCMJNh+w9V3ArS3PpRXQqzU8p+PAja7eKkmLK2jPo5X/X+0REISootsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/nTHonR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so1659705a12.1;
        Fri, 16 Aug 2024 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723842695; x=1724447495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WxOXfxQX0MfWi047Yxx88FkaE7RURXklWJ75UAHi9k=;
        b=c/nTHonRc1zkDgtKiorIVcuQO5v7jG4gQPe8NtPQ0Ml+H/9oyHkduSGE5Z8xQoQCpy
         oCVMY7t0I/8FtrGaMbkzinkMuAmbwP6PVx24VQ7+n1BaxLoAiO3BywWvjYcOxKZYtnUP
         AAXjI4B8B3la21i8fio86dA/ln600flGUro64LQNMr+WThNj7EJf9l+MBBTBNQJ9qGQK
         OqV7zI42BE+wqPQBiDUkuAaekiDo8fuKprrWoluQRVDD4WVMZkAsJbWFBtBixrFC6f0T
         KwV8I5p7PGbHR/dzWCQq6glX7UU9T38xfutfPze2vpBVkpPdDe5s9iRYd+fD+dKmqZoh
         tOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723842695; x=1724447495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WxOXfxQX0MfWi047Yxx88FkaE7RURXklWJ75UAHi9k=;
        b=hRdERFgXfdyfgO4KUN5hq08nXdfZHE+QAOqr3LuX42GLtB0w5QW0/36yIEp1i3AAAy
         ZPWpT6Ajyw4vNjBSeNSSwt1JRFl9SjL+L/X1nq7o8ugjRsZjwPXOxc8WW4yKMs3RPXpT
         XILG6/PIzcJJOnYk7KPJyFYW34DQMCu02kekpqpFk59B2ULDZy/jhTnx95ty5FgQCEdS
         rkor3RgwCqib2vGjXo6H7rwhuwQKIs7annK65M5xRFGwPPbGIbHSBCxgUUap5Qc7Cv6W
         2I3aZwR7zXqmqT7W4XqoWAGYay3N9zTHAN2gFVQCIqwBwS4LmJIN71V8mRmNFwDXYGe3
         xnBA==
X-Forwarded-Encrypted: i=1; AJvYcCXImQ9yJGplkRLpcRH53LC4KxL0AujqMmBQfPINmuzwvmrDEyw3Y/qrjIbIu3oev0qVJA7z8wyC+KNxqDw+DrbtonYOWSw7VqKQ2zySCD6kCLH+5AM+RYFuPKPlVKZ4G6YLUKl+mw7y27zBU6I=
X-Gm-Message-State: AOJu0YxCb1DAoL3x5uFCDoP0mtUejyj4G+oB8jcflWUK1tEnWo4NDxMc
	SI8RothQaUUjH0rzn+L49W0Vz4AJZ7KDV3Z+Ku0e8ck/e1nugJbfTYF+MKwOoST4q8U2VvSuy/R
	3d6G30IVZFwhmWjn7/86Rn1/IIcU=
X-Google-Smtp-Source: AGHT+IFXNkdgnRCRwit8E7FnnxLgHUWJ0EeiZ3mhwobxOiM2DOvYorRxtTh/BpXZlA1zdsQnoy40+2uvSVHeU2VXzGE=
X-Received: by 2002:a05:6a20:c706:b0:1c4:f1d6:e5e6 with SMTP id
 adf61e73a8af0-1c9aacfbce7mr5250531637.18.1723842694574; Fri, 16 Aug 2024
 14:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-b4-rbtree-v9-0-425b442af7e5@google.com> <20240816-b4-rbtree-v9-1-425b442af7e5@google.com>
In-Reply-To: <20240816-b4-rbtree-v9-1-425b442af7e5@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 16 Aug 2024 23:11:22 +0200
Message-ID: <CANiq72mr53kE2s3so-xK5BpiqbuH+cStZ6qrN9X6TROBR6WAHg@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] rust: kernel: add `drop_contents` to `BoxExt`
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:48=E2=80=AFPM Matt Gilbride <mattgilbride@google=
.com> wrote:
>
> From: Benno Lossin <benno.lossin@proton.me>
>
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e=
134390ce@google.com/ [1]
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

When sending a patch from someone else, then your own Signed-off-by is
still needed at the bottom.

By the way, since you are editing `helpers.c` later in the series, if
you don't mind rebasing on top of the helpers split [1], that would be
great (I am putting that one into rust-next very soon, in case it
helps):

    https://lore.kernel.org/rust-for-linux/20240815103016.2771842-1-nmi@met=
aspace.dk/

Thanks!

Cheers,
Miguel

