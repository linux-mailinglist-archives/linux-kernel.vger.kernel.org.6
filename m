Return-Path: <linux-kernel+bounces-429704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE59E2096
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D4E284355
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2F1F75A0;
	Tue,  3 Dec 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHCw6V2i"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D01F7584;
	Tue,  3 Dec 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238046; cv=none; b=HpKilB3UHSFa3lTUJoHbPi8nw51eTKUiCVT2lFWTmrlIcJWgA6ZhRZxiMOUZ/WjSseCx8BIBedZrKB2AblWVITJyiQv1CGIsbR8Gom7xJ6bDY4z/2GJGbQcLyOi7NI5UyWw0wgRRU4acCet2Xtb82j2hkjAwpqjUFPhPA40Ry+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238046; c=relaxed/simple;
	bh=+GTXuoJPpUkMVaJkRiqJJf9R9xg/RhyF+qF7V+xU71c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7KfwD3OCXx3d6+NvSNWjMAyujoti7molxWiibDJ9GvaJ5wTtDDFlP1bShf4izpxQVxrMykKS8aaAgFRHFRQxsK7RpCCRzk00W9PLrtH0D3go4uWiwKFuXUap7Tm8W+mVf7jTbS9KsBdt80/Dcd5pP0y1yOS5fV1JtwV3Kb0ZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHCw6V2i; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffd6882dcbso44294881fa.0;
        Tue, 03 Dec 2024 07:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733238043; x=1733842843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1I94KjssOpjSTWgDZ77I1QizZo12UktD/Vole94rAE=;
        b=nHCw6V2ih1svMxXpVqkxUoywXz6M61/2zg3rPprTqpjqLLZlrhuITS1i4vxMh/VI8V
         EDtbyiHIz+JFbloLV+J62e7Htd7+JPOkre+PHrbf4rHBxdyXIUAouaemj9CtbHMBM8rh
         dOf8naXmMYwwlO5NIHv+Le9nl4O0VmVP5eziqKHJa3WlbvhQ92YfszEvqdD3wDCwDQBx
         MCmexyCebv11nFvWvcmzeME483fa4NqXveR9GJoYaPpUIuHD0R5Det9Ya0CxBAXWKNL3
         DPSksSe7g0ttFrkjlknJE8D1uKWaTsF5lIDK+1Q8iJPuCGAHyIur2qLXaJG76B8C4c24
         ROFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238043; x=1733842843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1I94KjssOpjSTWgDZ77I1QizZo12UktD/Vole94rAE=;
        b=nPUPgaKFvKDS2fnczH4MuTQUpSf7AfEYlpGhqvAkw/dXG3ESfu5CuFvM5td/66z2Ws
         JDt8pY44aoe9TkRtJemzmdJODQ9eJ3LpDh3+f1AXK9na6CWRVaj487iLlgRwl0KUExJs
         urAg9+rRWN6L6qViuqOwPHXIr8FVxeb2n3O1VAGbdZDzt9i7XRNPkjSarr6RIEuT7Aef
         ckzpwKFZlA6Kl2/E3Jb04NLhXyeVm0Rb1WwQ9qv28EOc9gf1mMxpO4SqewpsAs08vmY1
         xhp4L5xpcgurfNoDj3aew1WNpw/eOX4EfCXTZnmH7QdgX2MSNeruKJ/CVySi0iUsPDd5
         pbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAPCRv6lz9CrMASaMdXum4AyxtIwCcIf2xpxig2odwkAYV6ZgQ26VetOkaj1KzX74ud0o5mn3eogy4xFxgH2Y=@vger.kernel.org, AJvYcCXpTtZbPn1hL/rS/3WNKvHG/hUZtx4ZCCBogdHZmvjuXIb971wwSxeZBmYzDeW3bjAtUmmBIaf72WxgRCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1LFGqGg+zuUjQT3ScGeQufCzbqhB5DncaRXbwETiUMO3aLPh
	j52Jvpa3KPpfE8NwvHBblI2+Krzd3QRCbwctc8sSazk2eK0/ilXuIjcmG+PxiqWayXVU7xQVy7A
	OOj5LehLZbD1V3g1Jj6Mh8x5mvPM=
X-Gm-Gg: ASbGncv4DgH9eBqWW8EibtpwSA1s92xAjYy1ZPJKfX5Ez7npsJd+VUNNGjORaQZNFwR
	ngCfju5WGhGMzqb62S3CM+mGswSicDumMsCUCyAswP4ycT3w=
X-Google-Smtp-Source: AGHT+IEc0lpKLWAwpwDRujL3XWOlOw8Wqm8R07+K3Wl0ku14itxI7Zl1pm5I3fzv/aHc72/2D/iuxqL3KnCOEwpLe5Y=
X-Received: by 2002:a05:651c:a0a:b0:2fb:5a19:5b9b with SMTP id
 38308e7fff4ca-30014dd8f24mr2560051fa.8.1733238041064; Tue, 03 Dec 2024
 07:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
 <6-QAwX1sgFm2t2PaGbx9Vw6zd35JfTSAuPp7yhzHZwErXXnBaRrz2lr-ACxVU1VnDQdEuDeN8Lv1PZjT6b13UQ==@protonmail.internalid>
 <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com> <87h67lezcg.fsf@kernel.org>
In-Reply-To: <87h67lezcg.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 3 Dec 2024 10:00:04 -0500
Message-ID: <CAJ-ks9mvAvRoRd+zncGU7RG7a_=X_mgvmU8BWZanOcF4tddbPQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:16=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > `XArray` is an efficient sparse array of pointers. Add a Rust
> > abstraction for this type.
> >
> > This implementation bounds the element type on `ForeignOwnable` and
> > requires explicit locking for all operations. Future work may leverage
> > RCU to enable lockless operation.
> >
> > Inspired-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Inspired-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
>
> [cut]
>
> > +
> > +// SAFETY: It is safe to send `XArray<T>` to another thread when the u=
nderlying `T` is `Send`
> > +// because XArray is thread-safe and all mutation operations are synch=
ronized.
> > +unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
> > +
> > +// SAFETY: It is safe to send `&XArray<T>` to another thread when the =
underlying `T` is `Sync`
> > +// because it effectively means sharing `&T` (which is safe because `T=
` is `Sync`). Additionally,
> > +// `T` is `Send` because XArray is thread-safe and all mutation operat=
ions are internally locked.
> > +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}
>
> I don't understand the sentence: "Additionally, `T` is `Send` because XAr=
ray is
>  thread-safe and all mutation operations are internally locked.", could
>  you elaborate?

This comment came from the original series, I'll reword it in the next vers=
ion.

