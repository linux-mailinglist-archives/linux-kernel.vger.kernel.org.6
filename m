Return-Path: <linux-kernel+bounces-401676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49DC9C1DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278DD1C22DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89361EABDD;
	Fri,  8 Nov 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdWFV46V"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A502C8CE;
	Fri,  8 Nov 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072055; cv=none; b=uZ8SFOJfm7OEpeaCO+pyqxokQ3BpMuNiT2H3xb3yl/d7DIPpLDEsmbUij3DtNSPzuOV80WjrNdvJr8V8NWeG9IqJ1ENd9gJ/P7BShf26wrHadXkdV4ewpQl5mNzqTA23/jTppAMExv/Fi8/qkFyNDM7iaK8DNQUclOsOixBG9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072055; c=relaxed/simple;
	bh=+Vu0NdkjYZzrJiDBh+RurPJ7p7WrDGT5U9nRXTfliC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opjph07vrHlyvLDLd66ikdCqrQ1bLI48x7HKkGXBZkPV3Y0lQfbGL+MhKZFdVUHC/kmWROzBHmehlQT1l9QkCoQZzvAvdAvLrj5hzFcSrJToTriInRXjOZ4XbUtauZkHUshFJKSKkCHkzL62HNctPdCHepePED2qIk4d92OpxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdWFV46V; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2327902e87.0;
        Fri, 08 Nov 2024 05:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072052; x=1731676852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Vu0NdkjYZzrJiDBh+RurPJ7p7WrDGT5U9nRXTfliC4=;
        b=PdWFV46VzQ8D6tvyxVWC1WwIsjEHB4xi8O7u7bP4gh1uSJ7vd42qxNpCzuAeowU3Up
         /ydThU4phEueyUSy9aQcQ28pdQQhUOdQJTuohOanPfpa/Iy+4pHtK3XY3aKCNRu8W4q4
         cQfYK4rF1Ua8NAaA/tR8kCuiAesQ37GQ3m4bSCDoidJ+MGITjcVQbB2B4yVu2HcBD/Vv
         iMaag356m1fNlHBlt/V1+dGxgDNEHHxMDpmxDt9QNAgsu6i/AuFjRmo+znNKsp1itIsF
         a2t5kVq+j2BQCiQZQfZAByVhGwHKyD9Pm9CjuZ9k5XrZ0UAZjk6BcN4x31xwH4EhKDty
         h1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072052; x=1731676852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Vu0NdkjYZzrJiDBh+RurPJ7p7WrDGT5U9nRXTfliC4=;
        b=nLttx5FtmktBZfNZtPVtOesbp47IsQWb+dpAm7MhXDw+w4hIaUNhoqKTw+SxmuJ3aa
         KVT8IBlaQVrUDPdQuoNkkpK80DqqGtQ4r7VfgcxGBPxXJAC81emKIOJkrztOMzAQeDml
         DKPf9OqIeBYDzvJ1nyAyJ0ygwkjvn2ZXDmkF6fJFcIqsH4hXSInobmsQDAhzUOGGI2MI
         +58OgcV6dCGT50yOjsPRTBCAgGmhn6BUo8T1dqqNahFmx2B2cWxsGMQWG4nMJxki0LBE
         Ucl7LSxUXbw/8LDK/w5ij1+sFMx+kNOlttmavDann2Wg9m0VjxoC4/b/1WTUQt6KQf+K
         tElA==
X-Forwarded-Encrypted: i=1; AJvYcCU2ewhxQqYV4N/5BuE/i0xY85WUmAY0xfVz9rwlkW2zD+Na+8bcDObSHW6ZaWVYytF8JQbybXNkWv8LPNIzTso=@vger.kernel.org, AJvYcCUln3ZAcrDeJ2hUooFD+HX6QwcwO/FT579bl1iA6zX8fLhiU43MV6V9LiCujPmnXG5/nTuaCQFObsHRRBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3FxMpK6/c3XdnJjZj+IULXuA+4X9s6RmEUNzMZc//bhESsvc
	Z1rqvEIIqZVBhnO3Yl1WpUHRrDm5Vbl08xb26YS6toLf1FhQElXUbxVanln4z2ssP9Vc9n1LHFE
	K0BVoOaCq8aIKHYCMkfuP9W2oZlA=
X-Google-Smtp-Source: AGHT+IG3QbkFZolknU0JmlKG7huI3T6ZhDa/csqvlotobdora/gpzCu6Nhmyu4C6vyGmRPh5ZIXMBaCY50E6Watwrjo=
X-Received: by 2002:a05:6512:158b:b0:539:f84d:bee1 with SMTP id
 2adb3069b0e04-53d85f13a7dmr1061911e87.17.1731072051531; Fri, 08 Nov 2024
 05:20:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-2-de650678648d@gmail.com> <CAH5fLghWusxAnU7avBueJmsdbvpoabb3=ckA7JvaZX6iha960A@mail.gmail.com>
 <CAJ-ks9=KuD5gLGh2q1q_=L0fR18HXQo7esq_XK5aEUoUQHSFQA@mail.gmail.com> <CANiq72nYQoXGBUG6yFnvNVgrJ8ZQBUsZ3ybYrZ=NHfPQpwEDYQ@mail.gmail.com>
In-Reply-To: <CANiq72nYQoXGBUG6yFnvNVgrJ8ZQBUsZ3ybYrZ=NHfPQpwEDYQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 08:20:15 -0500
Message-ID: <CAJ-ks9=mazJyTVLHfvgkw5=KxhXZHFs=mV8qq3du5gQHXQWFZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rust: types: avoid `as` casts
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:15=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Nov 8, 2024 at 1:22=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > guess the compiler derefs *mut T to *const T before the cast() to
>
> I guess you mean "coerces"? i.e. there shouldn't be a deref, no?

I was using "deref" in "deref coercion" sense:

https://doc.rust-lang.org/std/ops/trait.Deref.html#deref-coercion

But it seems that what's really going on is indeed automatic coercion
before the cast() call.

