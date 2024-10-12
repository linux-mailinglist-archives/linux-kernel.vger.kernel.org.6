Return-Path: <linux-kernel+bounces-362297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95D99B343
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F08A1F2250C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5594155330;
	Sat, 12 Oct 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc7ffhU7"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11347946C;
	Sat, 12 Oct 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731314; cv=none; b=ZKLMtvf+hv/FEnpj7ng9Q+cNOPFnvJrDy2IycNaUXKeEA5g0PJOokH6jtgHTbhJSy/GG9kIFAofBAkKzmTNpu8yi/bLYkoBzj8pdB8ZvBCRdQ74vzrAOfuE9ylxxLjvMQNowDY7fGDMq7M6PDLP6+bRRwtpiEP4ec9dIYEOhATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731314; c=relaxed/simple;
	bh=anKJOesLh0dpvN5fUmq7rV4ue0GviJ5ZaqwCQHiSo3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSs3vh1VOhaUdyzQX1XO/QHEHs/0S0Axvi+N2ttNVWhzYdgSvldr1lvkLc8vMskMzTepwA8DIMmjxwuuJQut/aj1CxNScVXAfXAn54SYZN9/ZK96FbQtJCE1WXH0lWOne1FP21/kOOI+ZuKiJxoDjQqiZx0w07+ev9pNt2qUDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc7ffhU7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso306842a91.2;
        Sat, 12 Oct 2024 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728731312; x=1729336112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXpQfdUU6RqG8+Te9GmI74BrkXUQuHFJl7lqEnDb0QY=;
        b=Wc7ffhU7t0BvJkjKVJf1qdSCGO7fb1HxX5Y4FRICmgoHmFWxYXqz/EdEEiIgrDc1eX
         KdFCwIVmdfdKABglUcIIUVQ4zx4E68ODje2kBX+DMdjGq8Yy6IsBlH+/7fqI9kR3Cpd0
         EIHhQ8AWIonssJr+Pm2w4FtwIHITjt3HkVkmY+TjPxcC8OIqV4FE2wpLC77FLE7B4e5O
         S9AGUCnbHdGiZ6NWovIMLVWrBiyU6q8I3daa6aDkkIq0q/oE8iLnA0kSTP7Mj1uUBO7q
         0yxMGyTNmvKUlHhKPrMAYO+1tyFqFDPyB0r6WjBx9tJ5IkmZHJ6WOImRE0J1DFX5QatL
         IoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728731312; x=1729336112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXpQfdUU6RqG8+Te9GmI74BrkXUQuHFJl7lqEnDb0QY=;
        b=Jc3U9N/IRK4P+NFMSrQD3Ds50y8WoOFmQ1SuDBRgPu05BSczuk19BhTo1P0/QE2NHA
         SqVZq1zD/M89ARXedJMk99VKNvLPTkXOxoNN4wXY/LTstEHw3jdnwknw0y9Ej8op/X3P
         wd4Kfppixwn0CTOEnCDZbBjQmu8eXkjGVkLL82B2t2z5WVl/huzvaPfgAUvwo3TjL556
         gHI4E4H7l5wR3HWNJwaG1TOd7A29kluxJp2jw6lMFydHeeKAcQ45ockAfijOFJ+VwwEA
         1eIhDsUqSTBTudZNk8Tj6ndY7OBUGD92yZYHJdBnOCLRH0GtfjsrwMyOQcctuJGzoV8A
         Sx/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNcj4gGY2klxDAghfCB7ZFPr/B4Yx5xrFbQSfwX6p8eFyVQoexS+nL6O0A+fVvp+JrmghnHXDzKLhkHkk=@vger.kernel.org, AJvYcCWmh6PHWVC+bkBwvYod278SO+MGOcSLyUQh2I4j1HFDuVAUZmdZqhw9jOplBb9wcRWPpMVBk6WALK2iEg33gbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIe+IScTgsbLZnygP1I3AqIpeEvtXEkujkrZ2CgJ65QWOEdX7
	siegmq2NdAX+tmX/0iCZAa/ZM7ks5M0BRH34VQOqH/XygSechrG7LoHIs5VPSo8iUlrpA80Atmo
	/iOYNjtTP+U6qfSb10tqo6j2CXDk=
X-Google-Smtp-Source: AGHT+IEnl6eBizhL/KUnxNn9a+QsJLplFC2sm8nTkqQ/Vhlea46k4opUZFsBOsyHgtkw2JwU3bkz7UAc+T3Ym2+XA88=
X-Received: by 2002:a05:6a00:848:b0:71e:4a06:8a62 with SMTP id
 d2e1a72fcca58-71e4a069110mr1956772b3a.7.1728731312294; Sat, 12 Oct 2024
 04:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012075312.16342-1-witcher@wiredspace.de> <20241012075312.16342-7-witcher@wiredspace.de>
In-Reply-To: <20241012075312.16342-7-witcher@wiredspace.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 12 Oct 2024 13:08:18 +0200
Message-ID: <CANiq72k2hDLf+PDkE6EQd7_UK2-XJYa3r2rVqDrjxARN7obT=A@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/panic: allow verbose version check
To: =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 9:54=E2=80=AFAM Thomas B=C3=B6hler <witcher@wiredsp=
ace.de> wrote:
>
> Clippy warns about a reimplementation of `RangeInclusive::contains`:
>
>     error: manual `!RangeInclusive::contains` implementation
>        --> drivers/gpu/drm/drm_panic_qr.rs:986:8
>         |
>     986 |     if version < 1 || version > 40 {
>         |        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: use: `!(1..=3D40).cont=
ains(&version)`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#manual_range_contains
>         =3D note: `-D clippy::manual-range-contains` implied by `-D warni=
ngs`
>         =3D help: to override `-D warnings` add `#[allow(clippy::manual_r=
ange_contains)]`
>
> Ignore this and keep the current implementation as that makes it easier
> to read.

Yeah, I wonder if we may want to disable globally this one (and
possibly the previous one too) -- I am ambivalent.

> +    #[allow(clippy::manual_range_contains)]

This (and the previous one) may be good candidates for `#[expect]`. We
don't have that yet in mainline, but it is in `rust-next`, so we can
clean it up next cycle.

Cheers,
Miguel

