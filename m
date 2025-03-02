Return-Path: <linux-kernel+bounces-540317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6CA4AFE4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE734177CAD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178F1DF27D;
	Sun,  2 Mar 2025 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foNhQm4M"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7671C5D7D;
	Sun,  2 Mar 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898461; cv=none; b=F5Y319cejjLj4LyhzJkDp5VJmI8/1G7/VPX/iBh+ISEQjj+mW/sQwo343lluwSsCinwxTG6CVO3sS+8zc9MPHg3xWyaQw3LSSO7SdZ93DBQ6mxhuy8li0RDtHAWEMSTHpbRoXQX+3GP7zWUATJONRmBUhBeKcj/ATmQU+RHDW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898461; c=relaxed/simple;
	bh=odNY4XzOtm5aV62NW+b9pTfuSooL8hassutZzyUijxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDEBIWTa8s+uVOcKMUhKr2gFsrPwfkZy3cw899ppXdBjLTH5Oa/dSJO+f+1sfKpr5S2vI42+O7ggELkjsmAU/Y1hCn6wQLluURwnLtQH/f2iU05ZMcNhzpGzcjlTpxU9kpofYPFHYgjqj+/tBduYOx1HbB4lU0UqvwYsMZh9eek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foNhQm4M; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feae7e56c6so860481a91.1;
        Sat, 01 Mar 2025 22:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740898459; x=1741503259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLVLObx6uS9bBjmY8f5wb7+n2yEgDTNv1aQqp5H8/BY=;
        b=foNhQm4MjFcZB6dU0Epk+NWTbYpxM7fWX4KyOaFbzm1KrcMOxwt0prCJW7/nyKc5nq
         hPgSEyIh4xX7SE4rK9HL2J4blcT2DohX3gjFG+cZoWlOL5dUrs7rKOs89Ua2nZv10M1l
         /kko2OREAGM986z4Z3fW/QQSan4SR0X+HIruCjA6BJT5q3GE1cdqCUOSqla9Pvaa0lPu
         eMf0Sf5YY43c+OibczMbaE9m0OW9oPIRs78RPFQixm0uml6BbAP79/RuqMIkVAGVL9eQ
         v8JTIDtczj5lRytOWFlUq4Q2lkJ5BaB2v46T7ag8MyX7BXtnt5iajtu9kvFNsykQnKQL
         4V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740898459; x=1741503259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLVLObx6uS9bBjmY8f5wb7+n2yEgDTNv1aQqp5H8/BY=;
        b=VHrkedWl9WT9UiM56JhXgPZ0EmlhwM288rZzGRDpIkLWq2I+kYS8Ah4DewhBZofaUP
         enBeSavLYT6/6xeewdoHySNds0fAvTwT5ZOulC3r3bBdmMy+AaPNdYKk5zmUsX1Ym1W1
         I2pmz/lhw6LEl5j0Dsj534W07rXn+8SDK1YFWRyyPtTysAQU69M/kcoIbKa19XYNjpaz
         ighnS1MeQwGEgUXnLuUXs58naEeLIOXfVp2sKRmprC7F4WOq0eJfKlLoxD6VSChmseQ2
         sAaNzhoJi9nC6u+TRiThFsj5FmjK3OybO2aGZ23RoiWcwEPEkvTk97KMIxKIfykhktmS
         c9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzIqMqKfDsUoCxSfAu8lD9bYCZuFT/jJkJdZX748gJKi+RXW6ksbNsZQkc6kSog6F/OmXuBog6AqzrAbQ=@vger.kernel.org, AJvYcCX5lTsxBEC+jYmdeQQY/ma4YVwqfL4Li+zhyj1/4FWPvNBb3dKUoPyEcy2j3ke43FWDAthOTvohUoUhwKOanIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNyMw8Cm58l+jv0dGeBSnO1LgyxGThT0FSrevo/fB9um2s3Qw
	g9yGSM/1TklfBmCywol7/8pR/5mhTnbmN02C8KcaIXy3xnLo3VjHQV01DwJTr1Dzi6yJfLD9c3+
	EXwHLJ08TXjvt12f8NwIa872LjnM=
X-Gm-Gg: ASbGncvq5qOAzrMsrqn/nPim595whjdgj8BphS7AVkecIyPWAyyd6GTUdiQ9GPT5SCu
	PjFJzuRj4qnS8erBc1/q+iRqUiV0JvkIg0sU5H29Ri5CXhVEGUYOSLn8msRjcI8ZqU+ztGSRYTx
	Ijox+LExXq18E0BrHUxa63V3z/vg==
X-Google-Smtp-Source: AGHT+IHh1k5f2tWxMNYSe/y3kE7Ra5Zf6Er2pwX6coXwO+JW2sI9aLEqs9LceEvDYhdwv4wseu00qX6LVvsx+04aHts=
X-Received: by 2002:a17:90b:1d8a:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2febab2bdf7mr5608489a91.1.1740898459164; Sat, 01 Mar 2025
 22:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301231602.917580-1-ojeda@kernel.org>
In-Reply-To: <20250301231602.917580-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Mar 2025 07:54:00 +0100
X-Gm-Features: AQ5f1JrtjtdA7vxoGkxnJQQ2oihRlgLnRnvB1-jZWod_EJ2aQH_uVcVqeA0S0x8
Message-ID: <CANiq72ne57qiwgWSDE=C1bvBuYGsUg9f8PooM+V_nZFo1Z5ogQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panic: use `div_ceil` to clean Clippy warning
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 12:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with the upcoming Rust 1.86.0 (to be released 2025-04-03),
> Clippy warns:
>
>     error: manually reimplementing `div_ceil`
>        --> drivers/gpu/drm/drm_panic_qr.rs:548:26
>         |
>     548 |         let pad_offset =3D (offset + 7) / 8;
>         |                          ^^^^^^^^^^^^^^^^ help: consider using =
`.div_ceil()`: `offset.div_ceil(8)`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#manual_div_ceil
>
> And similarly for `stride`. Thus apply the suggestion to both.
>
> The behavior (and thus codegen) is not exactly equivalent [1][2], since
> `div_ceil()` returns the right value for the values that currently
> would overflow.
>
> Link: https://github.com/rust-lang/rust-clippy/issues/14333 [1]
> Link: https://godbolt.org/z/dPq6nGnv3 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Cc: stable@vger.kernel.org # Needed in 6.12.y and 6.13.y only (Rust is
pinned in older LTSs).

Cheers,
Miguel

