Return-Path: <linux-kernel+bounces-401671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDECE9C1DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8DA1C22E18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B51EABBE;
	Fri,  8 Nov 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1f6NOPB"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F5C8CE;
	Fri,  8 Nov 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071756; cv=none; b=P0nGvimMq0KDacxJPRAXEOmF3Gjbw/42zuKpa1+IYDGabRYahORjpFUGpU2YkQ2jTIh5paj2GtqHqoJy/wZmWm0JKaiSTzr5+RUgttrxP5rcslGXMfzIYdELrku+O6kKPi2WxAS5stKT3fiH9PJjXpAM08c8mfPNVWk4EYE8Hz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071756; c=relaxed/simple;
	bh=+4jL49ZR3bSv1G6uBjmPLNWDpORbeI5s0MK1rEAdE9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaLMSTUHUs78Gg8ei0Y5w54tfnjwFoSDhN3xm591YnrgaNzg6GOkGBOX2E0WG1x49uSj6Q+l8HOqYmnfLX/dVWsU5u82pOOdErF7qdr3x2uRPGzIkQlKft17aoYRY+PImH/+OnxicW1KaBz0nPHIHrCxw01y6i8coQXW50h0ObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1f6NOPB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2d1b7bd57so230427a91.1;
        Fri, 08 Nov 2024 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731071755; x=1731676555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4jL49ZR3bSv1G6uBjmPLNWDpORbeI5s0MK1rEAdE9M=;
        b=Q1f6NOPBP8sxve1fxgIFrb3xQcyb621Uto/zr83goSHKBHj5wjcseQxFTg6sDYI/fp
         LRQLY6wvjhF0IKCvsbMPvS03lhRjrrzXMKHzCjxDOrVada5L9I+TkisElbjqUQoLsoZF
         OQ9MJ5+h1ZzuP5qsvCUI31wKX/Upg9HJLfdeUPIHIw3y7L73rRy/3rWj67kDd1mw+/7T
         varCkGn0jpwujIV77TfR+t0lD9hWNBeOTMmEdK6iH3Vbl9gIcm4zhgP8xChtfOwqIEhG
         HkkgOnre2l6/8TmDIyqHaZi3vcmhWcFsY8iAimsE0/Kd7waD9ASGoSNgfHWXmePiCdTn
         PbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731071755; x=1731676555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4jL49ZR3bSv1G6uBjmPLNWDpORbeI5s0MK1rEAdE9M=;
        b=cpKcuL7m/nMPuzNz+DgEc/xPxmrakzymDoCt9xbKJGy6UvzRXF8ct/gZ0EHH4/ZSaL
         b95aiXVnWKAVC/0GtchZuVs87ZRHjc7zSUcthotvZA4G9+Pne4Uw1DH5fAyn4knTZNIG
         1ky68PYX54qRnb2yMrPtTAqwGULavvcUBT+NcGh9s3kyYVvl92pJI4U/lLOxoud6iQw5
         iGpkVlWz2OAVqCm2D1OQHLDCBofp2s12uE4bbh8JCPv3l/JTppDfgjg63FQyrTLiw59c
         h3GAm3O6bjdatunvnsdLhe34G6VKusQtVd2PqClWvtpU5dEHKnHpi+j+11SkSRmgRrnc
         xApA==
X-Forwarded-Encrypted: i=1; AJvYcCXVmBvnfQaugVSE3zy2yzKDeLNce994OboUen/bm1pExIQXODpDW53vFLR/u+LmgL5ey/S6IMJjSJ9Cl4diS3A=@vger.kernel.org, AJvYcCXt7cAp/k+vEGkwG6UC5gz/3Kaedm1dDi0hlVscR9EL1xKx5omuymV3ATp8odBvuW7naRqj//BPRdab/xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEnbOx66aiV5AcTwGW8Wn1lgcjZUsdACTDMnV2Uo0Vu5qj3LE
	oOF7bTWl4uQnwuln78M3gEVlnneBWkF0ZpZogRhfJ9pzxFbRdadWArHGs5+DJxO5GTKY8+6ib8N
	aPUaIJhhNxDURIa+jRo2XKkGXjHo=
X-Google-Smtp-Source: AGHT+IG9q0rqQAMP4fCHO8HCH1j/2BAliJXh9FWZiNM3hnkXHOK19pfTJL6l+y1qcJ5jIq80lLMt4oqsYhjsjU3LEoY=
X-Received: by 2002:a17:90b:4b52:b0:2e2:e545:82c6 with SMTP id
 98e67ed59e1d1-2e9b14bd556mr1716201a91.2.1731071754743; Fri, 08 Nov 2024
 05:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-2-de650678648d@gmail.com> <CAH5fLghWusxAnU7avBueJmsdbvpoabb3=ckA7JvaZX6iha960A@mail.gmail.com>
 <CAJ-ks9=KuD5gLGh2q1q_=L0fR18HXQo7esq_XK5aEUoUQHSFQA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=KuD5gLGh2q1q_=L0fR18HXQo7esq_XK5aEUoUQHSFQA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Nov 2024 14:15:41 +0100
Message-ID: <CANiq72nYQoXGBUG6yFnvNVgrJ8ZQBUsZ3ybYrZ=NHfPQpwEDYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rust: types: avoid `as` casts
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:22=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> guess the compiler derefs *mut T to *const T before the cast() to

I guess you mean "coerces"? i.e. there shouldn't be a deref, no?

Cheers,
Miguel

