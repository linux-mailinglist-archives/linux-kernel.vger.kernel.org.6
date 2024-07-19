Return-Path: <linux-kernel+bounces-257564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60E937BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD03B20D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9ED146D6A;
	Fri, 19 Jul 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+++FU7i"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214998F6C;
	Fri, 19 Jul 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411830; cv=none; b=uGRcnZX3DnINxpbZqnWP+3UlgE7NryZNUL5ULOSL81/PPNAhIMBhK+FeqGQXacKoj+pj0Iol7ITksMCdBNT9P1MFc34NrTAaRsPn6Ti+ul3PEbpexFqOKmu6ZDSf+tdDi44myyDWs7YxR5QN8LqnbT8OqFxjSgLCO0r5oUwKd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411830; c=relaxed/simple;
	bh=sZe5NICJxBIGGwfdVZnIvSZPHbG9mAj2IyGZX+wRGn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3C2xdIuLcmlvomajRsdR7cVpZFLzqL7oSXqvodv25ltwYUnAQjnxm6U6J/p0mr0IYz3zbytwbhiBMzhneIPMUv1MFgfj1VlTiSJGCZlEJxlaIGsno2TqIifiXOy3srGsvqel2ZtIeW/AgzGxrpAmkSNLrz664c2OlZeAZcZcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+++FU7i; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb5243766dso1194057a91.0;
        Fri, 19 Jul 2024 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721411828; x=1722016628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZe5NICJxBIGGwfdVZnIvSZPHbG9mAj2IyGZX+wRGn4=;
        b=R+++FU7iPt/dkN2fZJMo3f/OjzkItEjYMB82FkrnQ5VIOu1X9kEeKznTBy9FQEFlrT
         X2Qnl5Jxl3b0i/xhuFLI3ST0sKexIPTjMHzJHvyOkNiHWjhTZoLlEO/3BmfA2M6pwy8o
         NAjf9IQZstIOzYj9bn3USkOBfhAXnXsirJSgW5hLbFC94QkbPZ5z/y+rmIbNyPywYna8
         nXzsC0b9kZUU8wGZS52I0FpK8hrkC2zSbpCa3YGtixD9Q0DQNVPy8/T6J1jmvyjzZCIL
         GbpeQOd+gdtcga0DiaqsUcCkwwsPXoIVTyVLEvXtr8gi+X3Q0GvbXVTCHr044m7Rwg3p
         cRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721411828; x=1722016628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZe5NICJxBIGGwfdVZnIvSZPHbG9mAj2IyGZX+wRGn4=;
        b=dcdZg/2Wn6QI2FUaFzrlrA2aV2PdRQ7WWyB/Ia3Ei89J2pHoHR3JEmqfJ+8KW3jIyE
         S4220clrhctK8U/GXfn5lc/PvwOIUMmc/XAhAngImQGBq9zH6kprRpTlkEs+7SqxuNWr
         spNrPA5asTZcUjErPkFtuxlI5ZqqFQ0GhaVd9GMMdwmKM/szldxanYX9Y4t+ys53GnJj
         sHhSZNe12rJjU21nBWheaoEyFjle/us+JbdMlhn0TRyRftD24rIgzZ2hTk6GrsKW1nIF
         hfqweiDzbVaiJ+VrSQfbrADsTEcw6jvErWkH8CNnso4+dy6i8IRUzIhQu9ThjW335qC4
         g6YA==
X-Forwarded-Encrypted: i=1; AJvYcCWqkrQPD0ntY5btwQcRBui9YRk4h53i43cBNroodTvV4EY0Uc6pgJZT/3HNyafKAOpEjNI/xOL5IfcXpXSdzEFmAelv5PKgMmqElO2o2t1/qx9UWqwHz5lQ2jCEQc8MscDYu5li6+VjDoRl/WMK0Qx4OF95xMVpbtX+1661liEE+OFECFNhoLA=
X-Gm-Message-State: AOJu0YxdpOF3dlVkHVVBjow3FIBqf69wIBoOC/lRjfeczTvr+O+2K0jg
	IG4OGzh24UwdCKY5Cq5K5pklBo61CnUCXyNubpZvb4uvOcbrP59Ogbd6sxPM2GO7A8fey9/P4ZO
	7Dc7vY97sJmlSHsVSs5bW0V6Srl4=
X-Google-Smtp-Source: AGHT+IFdQbIKZHZdwaeAZpiKJ1fWp0z5cxKOJoEPlBAQ1p3COkCo6uTqU0nJ9ai8Rg+c8DpWWgW4HSrNMdJlTNXYIxQ=
X-Received: by 2002:a17:90a:c28c:b0:2c9:5f45:5d2a with SMTP id
 98e67ed59e1d1-2cd1604d7acmr669732a91.12.1721411828356; Fri, 19 Jul 2024
 10:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me> <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
In-Reply-To: <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 19 Jul 2024 19:56:56 +0200
Message-ID: <CANiq72mxh-7sSj9kTVGENWbcJtbrbzSfksYhKPOap2UrvgZ47A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Jonathan Corbet <corbet@lwn.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	=?UTF-8?B?Q2hhcG90IENsw6ltZW50IChNLik=?= <clement.chapot@polytechnique.edu>, 
	Baptiste Lepers <baptiste.lepers@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 6:24=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> For these corner cases, a simple safety comment should suffice. By all me=
ans,
> let's strive to push as much of the unsafe bits into the kernel crate. Bu=
t,
> IMHO, we shouldn=E2=80=99t treat Rust drivers as some unprivileged entity=
, they=E2=80=99re
> also kernel code, after all.

The intention has never been to forbid unsafe blocks, but rather to
minimize the amount of unsafe code as much as possible.

That is why mixing Rust and C in ways that make the amount of unsafe
blocks increase a lot may not be the best approaches. Sometimes it may
be needed nevertheless, i.e. there is no hard rule here.

Relatedly, on the topic of drivers being "unprivileged" entities:
anything we can do to make any code as "unprivileged" as possible (in
"number of unsafe blocks" or other ways) is likely a good thing, as
long as it does not detract from what actually needs to be done and is
not too onerous.

In other words, part of the idea of using Rust has always been trying
to see how much we could tight things up while still making things
work in practice.

For instance, other ways to tight things up would be disallowing to
call certain APIs/subsystems/... (i.e. visibility, which we will add),
marking certain crates as `#![deny(unsafe_code)]` or other lints, or
verification of certain properties (there are researchers looking into
this).

But, yeah, I agree it will be one of the interesting discussions at
Kangrejos... :)

Cheers,
Miguel

