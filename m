Return-Path: <linux-kernel+bounces-342803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11477989320
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356E71C226FC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A784E18;
	Sun, 29 Sep 2024 05:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="GHsHKypO"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5717C9E
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727586667; cv=none; b=lgkDiebjilj+eu8vdh4MDVc3xIyy4APtC87bNDFRLpM7l89ZU6MuU2j590XZ8OGNFK3a+sLxLcpE4EWo7t+xXmd/PgoHOGcHFNlRWj7ihKOOw+iSRfRIq0F1dOr3mw5cWzxhQIPXA6jk9j11qgx3NYm+TmBB0IbYJE0RNr2jwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727586667; c=relaxed/simple;
	bh=RuRZYVvei28eDcQ036NK5OQHIXSS5Y8RpN9am0sKM4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpJGx2rPvah+MLCG3u3OutNR3UJ+qTK0eGWPd0zpW8klx2puFNUCgksdTr4kZLatm7sutNO6CZoQmIHH31NaM0w1KTZu/TzVn8MWcmO40MOD6JbURmMgC6Wind1CCfX+BdZKTy+Og1F/9KAYg58pWkmna/DIDXFKAcL10bveevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=GHsHKypO; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6db4b602e38so27299247b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 22:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727586665; x=1728191465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuRZYVvei28eDcQ036NK5OQHIXSS5Y8RpN9am0sKM4c=;
        b=GHsHKypOzHZ4bYmcxf3vuQbYwLqT19xD/oYNIZDOcf+BzFZF2/zMNczUgXiFzAVkZr
         xUO+cXYbyBdN9zTQuuPy777zjGb2cTgzw6qkN2hATZBorRQtkw2Gm2681rymWU+23HOL
         NQtllUjCR6LAybPlFJYGkcUjdDQmKKhtYgjZJajL7hgVzfqZLl5p0kaWsqqV1f2+fvJ5
         Bmvd8RIEKg4cZsMpU5adABfDsFh9DAV2uOucmgfdY9X8/wKloG0fOsQI3UllhHBTTrBP
         VO5oTf3C/ZHmGqAUbWVmfHpMIXtCErI3YbMD7t3Ad5LQlrPnDkr2/L3ujzzW3VbhijiI
         YoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727586665; x=1728191465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuRZYVvei28eDcQ036NK5OQHIXSS5Y8RpN9am0sKM4c=;
        b=VCk5yraoY6EMCYeU3f5pYA7I4Ewj0XA3VvNjJdQZN7SZqkuXPga+RHft88ywfJzXAJ
         lEg2Mf0Qhb/ffMxWwlttND8SACiVll9OmlhoHHNThPpvJ5VVxJh6lb5NaBcpxEFmjx5R
         WqU4bmBYFG4fu2xQYAGwWjjJsxljppPcSOA7Ppo7/ObgsKgbwqpBqIEXs1Nfb60p5z+o
         HBTGptDBhY8FeUKbaieP/sbsQ27R0byRXWNyjuzWSCbXSFqHjzkMHKBt/jSqvykXfJRs
         G2J+1Kv/heqTgvIx6OtY4aFBQXsMEZoclFW1EHUvxOajUCJIFAuj2++G6Nz/R1xpr66a
         F9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBIDo04stEWpJT+E9X1F8mn7E7ZJm7uVdCgO0buqsrjo6HtEbsoL9a8pa1vzXxhPFcyM2ygOhAa6q1wSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MwZ+pbyB1sD28DFFJDFgTrLAagEB0/0iGKhlmMda2jpSkfgX
	DvalrSwB4B4dB5dT4QDGlTgx/Y+t30nISoHe8g7/2ESxB8FwDt8WYdh5Hw2ou/BypvMgo7W8RDA
	XmpAW3Vo900uGZohrXXklSeAqTKB+jHNqmowcng==
X-Google-Smtp-Source: AGHT+IEbuPLIS0r0UAYXOL55sJ7MsrTfAySS4mECInBKGc5OhJ5B2QgDR/M498wdGIiCmNjzbtv73pF/ogEFQj1XJkw=
X-Received: by 2002:a05:690c:26c5:b0:6b4:e3ca:3a76 with SMTP id
 00721157ae682-6e247571063mr46680857b3.19.1727586665054; Sat, 28 Sep 2024
 22:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-19-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-19-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 01:10:54 -0400
Message-ID: <CALNs47vPzH7CSjRh=jW0xNTh9=oajUs4SAkTE2OHLd5M2e065A@mail.gmail.com>
Subject: Re: [PATCH 18/19] Documentation: rust: discuss `#[expect(...)]` in
 the guidelines
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Discuss `#[expect(...)]` in the Lints sections of the coding guidelines
> document, which is an upcoming feature in Rust 1.81.0, and explain that
> it is generally to be preferred over `allow` unless there is a reason
> not to use it (e.g. conditional compilation being involved).
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Would it be good to mention that a reason can be specified with
`reason =3D "..."`? I don't think we use this anywhere yet.

