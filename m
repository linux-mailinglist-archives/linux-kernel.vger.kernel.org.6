Return-Path: <linux-kernel+bounces-433167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9889E54AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E7528199D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845442144D3;
	Thu,  5 Dec 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3fj/fFx"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E612139C4;
	Thu,  5 Dec 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399771; cv=none; b=T+mX/oK1nYe0BoNzsMBHyg2aq0+KRfpsbdJZnkanxuUMvFPyTqbBx0rHBoybbm5Iw3eOGp3is8uOZ166C4MlC1EAt5xB/Wal93Ivd6vvt2OiKrX1LNYpA4NXv/YWS82UdKJZIBEHEjTizxTaaIWcCZN02AGUjwGE/mdGAngnlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399771; c=relaxed/simple;
	bh=kCf16RN18cIUR+O9drnAiJS+Y+NFHBMSQAI/3LbxQAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saSkRspLEzcvwyZcPizLjjQoftFlZFKRAuDhVptbXK8BrxI+k8R2VEUXCPSwyLe5iVdxRqbu+c8QlKJhCw7BLGZBcpf3YGs6MUUnMpaSpZLkjxzB8mmcwLZk0QmD016B5C9OimmuoQUWVB2CbEqTI9gb1rGBDCkvqRf/xGRdYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3fj/fFx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee534d6800so128103a91.2;
        Thu, 05 Dec 2024 03:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733399769; x=1734004569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjdbC+3reTIYnarZ7ofLtxbb2zTwaAAm588wYX70/Ak=;
        b=l3fj/fFxPE3he2obFjEgRU1pPd0Sm2VoyCrNh6DOuQ1MQ1aZ/pCe1Tp5cfuC9Fo3QZ
         t2gJ3InDe2vx5hy8A1htFavDIea6Gy4vwTNxIyid1IRUGZ3cAai1UfssB/dkwd3IR9+r
         vNgv78noMtT/wvvQNnRIHG0w9Me5i5HW0tX2ZiNSXBfvZpOo3mJrWqfubBMdAos4kyMv
         YWlunnTPYKc2W7HXt6zYLlmWpTqG3NARIT8VEL3y+V3ZyQe8HM4acXMHZjgxPlHfeebB
         Jy1SQ44U2Uzob3gIIwdjKsPvT9y9FQ9nHEFUwYUkrlsy1JiTAnK2yLAtf7K64FJ3ABgq
         jAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399769; x=1734004569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjdbC+3reTIYnarZ7ofLtxbb2zTwaAAm588wYX70/Ak=;
        b=sbwMOSuj/CsFF6eQOaWjUTAC/C4s4kiMcEZ7vec+Zy8aSq1vcU263u3iUJ9ze1FfC1
         UpvXwLPJULdWUp/BPLt0Zqcnrxi9z9Cr/jhwn/3BY/91d+X+/g03Xl3xcsgoX2h8OdRG
         O5hWqo7mCJ8X3kOGNW9IKmftVUdhiQHoMvZt1/7wW4/Wye1d1FEsOpWrgxFQJqB/LRM8
         0n18HqK3QqT75YueGk3+YGiI6c5zHm+2oBaf49gSOwT3J+nwLxbmZOVpb8Vc3qYu8gdA
         IEF3QXxM14kQlFzCS7bWZ8C3IMGO8gVhr4+G5/rkU+bwi3wCZ1FAH2vqaCSum7JwFQ9h
         zn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwT76lxQMsR+sLfhCDAXsry+npPKbyIrZvaNq9IN3z6pdbonPwUyXN4ZtEdt6uhFFNlr6ff5E2Xyx8kQQFKjc=@vger.kernel.org, AJvYcCWT8ib/e8NPBO7V/NYVZQe2Mv3hYlg6fdd1rYSW9H5kb88EUCxq055OlAwiCsF1XKJP9IcCgsBBZxXrRak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKa6e+EKHZUn4b0U4fRMljb+6YbiapaYZ2vFX2hHktNFAe2Tbs
	uq1DQpMuaVolrztIiP3+ISP+2DIQSGprqd3j9rTltZSrxfdsOcNW87J4sZy7ObWYHLWyrYIMhB2
	Xc/Yp54RzVGh6CtgjAbOyJymJOhk=
X-Gm-Gg: ASbGncu6HzESwxIwEqEGbAsb0iK3mKmyKYlPpLHzBv0pXh+Qfdq6JczPFoApmx39alD
	Gc8gl+24p4LFF+uhbnzgEbIaMPmmuIRM=
X-Google-Smtp-Source: AGHT+IHr2MUdRouB0jKjxkgY6ZX0YH1VXID/6Xn+4a0HrJ7Sm6Gnj9dOuOErx+U73MCe7MuNQaX30m2FYfU4J79ENkk=
X-Received: by 2002:a17:90b:384e:b0:2ee:a00d:2ef8 with SMTP id
 98e67ed59e1d1-2ef0128353fmr5461030a91.8.1733399768957; Thu, 05 Dec 2024
 03:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
 <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io> <CANiq72m-dY0b7UiBiWOg8g1SFPqLxuhkDdWwNh8g8OBk-Tjz=w@mail.gmail.com>
 <OCjLJ1h--F-9@tuta.io> <CANiq72=A9=uzSt9DOZBvw3sHwf4vqX2+6MBDKO5FokZUyt1V3A@mail.gmail.com>
 <ODKVmiV--F-9@tuta.io>
In-Reply-To: <ODKVmiV--F-9@tuta.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 5 Dec 2024 12:55:55 +0100
Message-ID: <CANiq72kRiWoo510U8gkLDpyhNi=a1Ps034Dcid5jvLxJnbNRMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: error: Replace pr_warn by pr_warn_once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Rust For Linux <rust-for-linux@vger.kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 7:30=E2=80=AFAM <jens.korinth@tuta.io> wrote:
>
> Sorry for the late response, the usual madness at the end of the year is
> setting in.

No worries at all! I know the feeling... :)

> I think it should be `TryFrom`. The `std::From` doc [1] says:
>
>     Note: This trait must not fail. The From trait is intended for perfec=
t
>     conversions. If the conversion can fail or is not perfect, use TryFro=
m.
>
> [1]: https://doc.rust-lang.org/std/convert/trait.From.html

Sorry, I am confused. This is not implementing the `From` trait, it is
an inherent implementation.

If what you mean is that this should not be an infallible operation,
then we are back at my previous reply, i.e. are you suggesting to
remove the method? Could you please clarify, perhaps with an example?

Or are you talking about something completely different?

Thanks!

Cheers,
Miguel

