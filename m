Return-Path: <linux-kernel+bounces-401557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6A9C1C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CD3B22D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E061E32DE;
	Fri,  8 Nov 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSDelyZK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323D1E3DC5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065730; cv=none; b=evF2UyR7RXnIwJffnaQNoYiYI2tltx1sC2Yy8OPgcOk/wUEpF6dH3xxOxUwCO3fjN1FrzDMV5gxyJdpKK0fA2y8CKPI3ed+A6aAWo/GCRSaKakGw+/t4RlCvi2xO8RmpRa43toEf9jJPEtyUG3BBsimn1tFkWDsMY8EAnLjPErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065730; c=relaxed/simple;
	bh=PX77c9yHDgIre9q74xWnIJF95l90Y6Q7Shh8ZBDjjug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MytvmOaTTqrdYINDkSSXkqfLqvOvywuUW/9onHlecJ6ZLWEeUyMzOkF9NmbpPdkgtWhRBeZQ3na6SUIHGJTJPtydL/BNIJrY4tpVCk0GuEmWrJUxEaB7mxODt6VzNh7hD79kCkzVMzKQxoKZnOb0t9GjTo0NrQTM0Wcr+T5SbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSDelyZK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4fd00574so1147311f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731065727; x=1731670527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX77c9yHDgIre9q74xWnIJF95l90Y6Q7Shh8ZBDjjug=;
        b=sSDelyZKy7DRLtx/TaEFx23acr9fxE94Ec9sBp7YfHCoC5VPMl2/ufmsyoysx9X/pQ
         WvhrTKW+O2M6dXlE7bAzou//NnqBg0KhGxbVLAKcnfYzCYDYTny9TfYX7cTii3943Xh/
         q7140zQ27stLbKJi+fSy/NZ18BHm++0l9Uxx40Bsxk0Em5JY0zMpScardGCMKGWgm8gj
         n1mU2LnTWEJfTes2F9zNd+go7xA/S+ARhMv6VoSbt4x74GK+PoAsJaThkW7OZoeciD6W
         YuFSMUkgu64oYZqPDX1TEEa8U/8qa8Znmf30l0LKTQJmfOKA6ydWjGNWR+XfMEZdDQHK
         wiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065727; x=1731670527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX77c9yHDgIre9q74xWnIJF95l90Y6Q7Shh8ZBDjjug=;
        b=n12AGGG/XObtdUB/xkzzzGmMmdjDKaJUbwQEqGWaohqz/PhfNBvpG+45asAkPK2X3L
         PQOdRgRjywtlL/yVgzrM41fMZaP8nxJ/4n/JX0lfiEatSdF47hP8JlLlp/7Ca2VZtjj3
         BEjZZeA2HPrImskT01FJd2NbRy9+M1aPgkOsjglg9wuFQw3dDoh6BPZRCkf4Ca3cZrPx
         a6geQtTdsmA/5GRbT6ivy6mDOPp0xq1vfAURCmhmJ57MBNEHbeDzujh/zq7VdtqGIefs
         K9ebU4swFd0x2I/5jMh2WFDVSdOqKOBu+m1scE4U/KGrb5nkGl0f6Jpkmibq+1VUUwn9
         4oUA==
X-Forwarded-Encrypted: i=1; AJvYcCXnfQHMkg95wfuDm07CYfDGRyoIb73qiuZtTUEq0gS4B65leSm1TW/zbqkhA9I6leKhDTxKTxrLXyVkuZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQqkIIOm4uiJstXrrOnfmTruW+S24Lm4/N4TcmtxTNFxfFgY6
	GzJMVdshMDiiCr3sy6MKL0Z3ZdhkqJMIbplqmRfRpFbUmHcjXYoDMa/AVrrICpeE8mrDTmYNd2q
	JsrJ1yp+4oMX8zUK82cNuj1e6pn4gflVKSABIDmu9K/ikCHPWrw==
X-Google-Smtp-Source: AGHT+IH+oDbouFhcJmh4b7BSQ0gaytMeoLpOtxvYqsOEN+3aL5UukoywTdcI9d7KqgD/hivbt1ac5lGemIQRmmC9A+A=
X-Received: by 2002:a05:6000:4916:b0:381:ed32:d604 with SMTP id
 ffacd0b85a97d-381f1a6cb71mr1765873f8f.10.1731065727315; Fri, 08 Nov 2024
 03:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com> <20241104-borrow-mut-v2-2-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-2-de650678648d@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 8 Nov 2024 12:35:15 +0100
Message-ID: <CAH5fLghWusxAnU7avBueJmsdbvpoabb3=ckA7JvaZX6iha960A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rust: types: avoid `as` casts
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

The compiler auto-converts from *mut to *const, so only cast_mut() is
necessary. I think this will still compile if you get rid of all of
the cast_const() calls.

Alice

