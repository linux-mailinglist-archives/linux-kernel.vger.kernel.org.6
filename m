Return-Path: <linux-kernel+bounces-362295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18099B33D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406EF1F22516
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D729155326;
	Sat, 12 Oct 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkOKawIQ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACB946C;
	Sat, 12 Oct 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731076; cv=none; b=JeyRXOhd7tEb9l5isUcf031nJyttkLSWNt6Dv0PYVYhIMR3cEslC+L3EEnIwOCF34frMVO+n43Gp1TMWWGUj1MUxq/DevCc6hEHcEgRhWs6l60If9LA5eiGOZ82LeOPqzUU7QOjJU8oMlWCPly9K1QeNd/4nZtjkOKC8TKvLw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731076; c=relaxed/simple;
	bh=1S7XQPjauL4fA1RrelDc6zTaUMRlw03ylvjDe4mf7lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5BP+iaBX00ybHirNClrlr7buJlkK787Z/WZeQgAwruIgihERnoskmcDzL77BF2/qu38CbeSTS4lFiOWmBKzqQWTERU93t0fh/4Uon2ZBhPFSBjU/9jh1w/YU4y+b4RuWddgpI424XmV4ec/cJPWJtIv268lKIs02MGmXy+YYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkOKawIQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4eb91228so105591b3a.2;
        Sat, 12 Oct 2024 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728731074; x=1729335874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XroMpCi45CXQlHa3n5Z/flEDjCsFF8PBVEONJxRQYXA=;
        b=lkOKawIQzq8ZGftfZe+5gg5QmHkknoHURfRC0LCkQ4WesTqg4qq6l+FW20Vco6elKT
         Jj4v47q3DnD6sCK9D7MqeRUMOgUopKJJetZk37UjCfyn3mkURkSqyrBy6tIhj6sch6aB
         qV32uF2El2D1QnM4mVnfNG9Cfjqg3yOrxQ0CILjStmhSNoLcBRzQFp1K7TgwUfb/NaZn
         wW7TWLAGPdxG6ArLhAuib5D0E6lYaKX03MrTnPCkv9oZ0ZYL9yo76ubrwa5qsFbllMz6
         1srZoluyGB8ZGW+KBgm3p6rupPr0AN/1iXJq7w0NO/avYxhL45CsLL0st+z36GbgXdaU
         d6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728731074; x=1729335874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XroMpCi45CXQlHa3n5Z/flEDjCsFF8PBVEONJxRQYXA=;
        b=Ck9qIJpIk5+Zbz9vdqH9Pk/NtqzwwiCqtgwMSIgpQ3Xa1B1twHNFbUd0qNd7rrlQoB
         kRbWJc/mXcXkhilBkP/xOXZEvcRh5/AmFsB/SYGC0bPXcW3w73CKya/3BkVNcvIf21e0
         h9tpePFdZWWUW0TlrhPae9tK8QCgP4gaTDPBr8A7QwdklbQOsNPW59agsINDC37yHwEi
         nTSYNiLhIhj3PwrWz3kYjoB6eHDgMwM4+IxThQWbNP+LUivRDrCYypd7NoJi3QMEYBJK
         0jv99MFPs3bb+kwAshiciD3XiEygUzMPyUKHKoFhV3TF0uiAfDLCsYNiDukEBWpBKD4O
         NxMg==
X-Forwarded-Encrypted: i=1; AJvYcCVq36Msvj+6LSVT0NhS8R1VfTdBE2t1bzzIXadiRxETi7R4CkfJaA5oAxaFWJpsoVWMjagggnqZMHt5Ho/z4Mk=@vger.kernel.org, AJvYcCVqa3eySOfvSGxKA8QZ7v7ewiZoakAiu/qvD6UhwjKjGLfLksmeBRPVziVOoIyYWNCGag5/PsA9uJm/4SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtm2LHXPk2zCbPbJEU8OI8Uurze1+h7u3WC0gQ5IugOInH4Uo
	5EdaBQBr8YUsRdC8XHjwU5pQ7oMZx5T7JnfvMoZVQUczHiFfLbVE3O7wefV1VnSL+S/+8q5UYJP
	saapLOvNxMKFjJb9+1RqgY6bYsqM=
X-Google-Smtp-Source: AGHT+IEAt5tdtaeiDpoTuQ8z3jgt02TnSfq3bj5lSqXLETJJCu+grTgzCOvYTrYnuCyx/PBrK2fp1H4xRv/nRaoxmlM=
X-Received: by 2002:a05:6a20:a106:b0:1cf:52f5:f5 with SMTP id
 adf61e73a8af0-1d8bcef497bmr4471554637.2.1728731074631; Sat, 12 Oct 2024
 04:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012075312.16342-1-witcher@wiredspace.de>
In-Reply-To: <20241012075312.16342-1-witcher@wiredspace.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 12 Oct 2024 13:04:21 +0200
Message-ID: <CANiq72kG0Ai2DHfERD0aPDVuEpLYrZ_2uYdw17=eeHRp+2Q1Rg@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/panic: avoid reimplementing Iterator::find
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

Hi Thomas,

These commit logs are nicely explained -- thanks a lot for taking the
time to write each!

A couple nits below.

On Sat, Oct 12, 2024 at 9:53=E2=80=AFAM Thomas B=C3=B6hler <witcher@wiredsp=
ace.de> wrote:
>
> implementing the same logic itself.
> Clippy complains about this in the `manual_find` lint:

Typically commit messages use newlines between paragraphs.

> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1123

Since each of these commits fixes part of the issue, I think these are
meant to be `Link:`s instead of `Closes:`s according to the docs:

    https://docs.kernel.org/process/submitting-patches.html#using-reported-=
by-tested-by-reviewed-by-suggested-by-and-fixes

In addition, these should probably have a `Fixes:` tag too -- I should
have mentioned that in the issue, sorry.

Finally, as a suggestion for the future: for a series like this, it
may make sense to have a small/quick cover letter saying something as
simple as: "Clippy reports some issues in ... -- this series cleans
them up.". Having a cover letter also allows you to give a title to
the series.

Thanks again!

Cheers,
Miguel

