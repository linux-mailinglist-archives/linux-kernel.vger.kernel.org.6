Return-Path: <linux-kernel+bounces-261539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098393B878
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7092861F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C19213BAC2;
	Wed, 24 Jul 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuKufqnX"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C16F068;
	Wed, 24 Jul 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856035; cv=none; b=oxfHNGYFbxy4llalTCtX3Axf30HJ5SrwZqtMSNXA4eOmruzkuEH8XE+aFfQlRulyuJd4VtyB4IMQlCGMD3QdRMNluJ0rucmjNHTMutP56enDxkS5e6e5KFeCSWMkzyTxJSQuHS0T67tEYvJMBm5fj1efHrHzzeUv/2pqq0bKsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856035; c=relaxed/simple;
	bh=UAMquWpIpIMRQSj3d9vj/eyJdUUCFF9c9h86+1Jwbv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhOHDLH2y0CLkHL9gyIqvbe4ltugCxq/b5K+CJvbogJsTZMtBQhBkZ702/hRl2EdH0lgB7WwAMQDosKL5XcShYvgUXEPbVG5r/SbkxliaVZ5lNRnoXS82OUJvL6aNt1Yfki72IK/Am/zEehkJIswbftttSDobCHjvY1M4YiRIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuKufqnX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so213508a91.1;
        Wed, 24 Jul 2024 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721856034; x=1722460834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAMquWpIpIMRQSj3d9vj/eyJdUUCFF9c9h86+1Jwbv0=;
        b=iuKufqnXSdI84GwNY3Ffwm6A35H5Jp1ZMddKeP/+Y/0aCO+65yOyTxSE+g00Of7iLw
         mL5NLaaQLtK9JBzY9NvMa75PAqQ+LPrtY1PSi7D5n1DrdcXXS/rEmKrIGwqn0k5jOsRZ
         u1A3Cz3VG/9SvDQ9zUHhx6SgYeCSQwhTZsJbdQB33L1151tfZyZQSHW0v4AsLW5j0xYa
         WQOAQpNExPNZ8nr6/yJ3uxVUmkbWFaoxBfVAr6kbCfNfqmDEMb0L6ImiTEF5w/yj+Eu0
         H7ivgRvIXpZu+ZsPjxfjMDsJimGwsCrMCbse+oaDLYIZ495e1lS9ZNIqzoTdXsmbFVhl
         GcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721856034; x=1722460834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAMquWpIpIMRQSj3d9vj/eyJdUUCFF9c9h86+1Jwbv0=;
        b=jo5iSFnCeCjdOYlZcuTotzPclPGXu0oJyjUbsf5hmrBQDVhlOcs1XRGKauViYal3+c
         MAmmS/CGS2hA/vqjy00ZPwpiA7eSQrn0dgONWUs/L4vBFWW/e1q0cLWtaXWuGJPwFmU3
         reX0QA70Q95prcowOAFvrQ7dMeqVh+1byLuXL0YVKs/SZu8zi8JQFD/VxTSHLv72wJta
         wBk150SAEO1C+AEoIPZKftwhPoMqNAtmS54Glkw4jsemF0mswCnXQQ6ShqqitMs+vvgw
         ZFBswZfxLQhLuC16K8f9US3xkhB8qDa4B+n3ppFiO1t4GPa6DXeZKacLG0n1qbup24ha
         b9DA==
X-Forwarded-Encrypted: i=1; AJvYcCVRBLDkmX6RiNlBE+DSjtqXctcn+74sMmuleXY65moM1I3cIx+ytG+12kKAHpDTobObhaBpBksm/8QSqm6k+J5nIiprsdvIXazu7RghsWqhLA9CiDfKuiK5Hm6O4pubmf+S2rVPGV8W9enJpqmKNE/FAze67S6GhL63lEnhC6EmjioZf9QRFyI=
X-Gm-Message-State: AOJu0Yxuh0lgTtMeK2b9ypz6fwlQ/ptLu4YW+Z1rs3KeCnOh7lsgaAKZ
	DosWuylhjd7WXy14wATEdTyr23TSd5fsAH9/RKXIc2M2m1KjwtMx+SKf/m5BD8VNGak9Mns7CoE
	Lw/J2XzFfLwWsSijHsvDg9SaRCqY=
X-Google-Smtp-Source: AGHT+IFAqeQ63jXKHYj9WrIm/chDXE38dKQBRWtQsKDk7YJsAfKg35lISr1CS/rAuFWO3JOC+16MX0nri1Bkg27Nm+Q=
X-Received: by 2002:a17:90a:bc1:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2cf2380cc92mr943726a91.3.1721856033721; Wed, 24 Jul 2024
 14:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me> <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
 <a5afc0ed-2193-42f2-a7ef-50fba68980a6@proton.me>
In-Reply-To: <a5afc0ed-2193-42f2-a7ef-50fba68980a6@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Jul 2024 23:20:21 +0200
Message-ID: <CANiq72nFo2qBpKfZp5vcsT3PHdrfP8WukTkpC4jCnYW7h9A6OQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
To: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Jonathan Corbet <corbet@lwn.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:32=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> There are also several clippy lints [1] that we could start using:
> - missing_safety_doc
> - multiple_unsafe_ops_per_block
> - undocumented_unsafe_blocks
> - unnecessary_safety_comment
> - unnecessary_safety_doc
>
> I personally think we should enable all of them.

We briefly talked about it today -- others agreed on going ahead with
something like the diff I sent the other day, so I will send a formal
patch -- it has been a while since we wanted to do this (long enough
that we were the ones requesting one of those lints, and it got
implemented since then... :)

And we can keep the `TODO`s as "good first issue"s (I already updated
some days ago our good first issue about it:
https://github.com/Rust-for-Linux/linux/issues/351).

We can also enable the others easily, most are essentially clean
already anyway, so I will send that as well.

The only one that may be more "annoying" is
`multiple_unsafe_ops_per_block`. On the other hand, it could in fact
force people to think about every "bullet point" of the requirements
(the lint highlights nicely the different operations).

Cheers,
Miguel

