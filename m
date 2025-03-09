Return-Path: <linux-kernel+bounces-553410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1DA588E4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 23:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7369916A95C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763D11F8759;
	Sun,  9 Mar 2025 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+ULyt99"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936016B3B7;
	Sun,  9 Mar 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741560150; cv=none; b=cdS+qtyFWXSOVvP9aENt5fB4/3X2cIPgzhdKP3aAtGiQAPhfeN0YHuHxl6g/b4ulhS9bvAOhS4FiOheFB98oG5ohg52VMyI2HlmKDYlstUq7BPUa15SYczkOhw8Etb0+SdE0UxopzYC7uhVWwnzJbJa0I1YX3g8BsBefSY2Sdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741560150; c=relaxed/simple;
	bh=5CB5ayd2way5tvtIAWxW5KiHTACn2fM/EpWigbH/UUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efxNLgdUDpilnQfFocI7RCQJtyMnEDgEQF+0iNcQQxE2J+WR8yxG9gI/BUbbEVxKbpFTzDI26tIqmrLOeix1727Y7R/Pao1WogpDnS3en86GlePgazLjNFV4JWIe2MK/9u9LdzzBmX5IEivNE1P+mI9jcadow3P7JqvHL492Slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+ULyt99; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so1022592a91.1;
        Sun, 09 Mar 2025 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741560148; x=1742164948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDgs+PHaHT4EU2aaD2M+FnThaMxcV4VMX3+W4jr7pUE=;
        b=V+ULyt999QUY5sxfiPxkDPZdtcpVw4vorEQP5QHLn5Va1y5ZYYNv2L97XFky2qQ+5r
         FaxxS9vyH04NM1YbiFXDT6zSoF37VGRU3S1u0KgJQaRT6jsCW0qw+8L5ySGPGkztCX1W
         iGpUrorhZOSFl/Mht5BE+doM08wa46PsyF3krb522ca0m5tlMVSlOQjlbZLObZy7EhtZ
         AFhPt4C2ni648GcUGOmsZyNB+rrVYat/XnuPNOwXPfFudOZI2BdFbjtDEK3vvubtn8I1
         FttckruOxdvysw7s8plD5e6bxn98L54240G6W/t0G2n0pWXloIJ28CxQa9PAE3eJ9WZf
         nyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741560148; x=1742164948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDgs+PHaHT4EU2aaD2M+FnThaMxcV4VMX3+W4jr7pUE=;
        b=gFtTC481O4W5apgWwXu3o5T7D4qsclG7TuLcB1TZFWbXK+fyP75mP3ZRm4c3lcydzI
         c+O05q8sAnfaqDjkS6Q2dcT3FSAO1v4zDSQHh3XtEbIzfo0GA1hg6k3EGZ5SjdRh2VHk
         jCXLLgv7jq2MnBPH9DE0LfKCn/BNN5ifzgPrfhjRA5nqLk64LGkFBhv3Y+bd+37lHxIN
         oefF4CkauOpoqE/fnHGJ5SMsjwgI+YfpBIEuUSrrHanVBBvD0VLYOHA24T1ufNoOdlSn
         U5C78kkGYSguR6RR7c8qKvcjKg4NiGuyWy3na+tnGMEiMXyttYAIfWBGiZBSXj6yu0vj
         wTQw==
X-Forwarded-Encrypted: i=1; AJvYcCVn0oJ8ZBatZMPuKAr264seIo37PP1gFngYtyuMePYi5BQFurS3fSSyYGleQEkEYV2J9GPhPPGfUxLR5e7bNOw=@vger.kernel.org, AJvYcCVsOc1PJKVflrpjpZM0+DK/U1zXGF/MchJWxKk6gNBWNCyr2f+Vnvi9Ufpw1dJcu6OLTnw2+jvcgXkfQ74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHulTVeWoY2/3eO8zrqfRqcmeq25ocStJDqOM9HfWJ9hO3wMn
	TyEhd2zNHkHYEMJ/pQXzGXC6mOXhxPJb4wjvFbt4elUqV8c925Djm2iJLve9cuIWTIT5x2PJ5Lj
	Y19QKCG5t2xRDWvxO5ALl3mAg7Hs=
X-Gm-Gg: ASbGnct+qjfDojhx6rzvkOCWCWyetn+34GWq2M3x7ZgxYuEL+7M1N7xCHiHNFRyhV3a
	Z3QY8r4Inke6SbBcbOFtRRurH1gxlzrKMW7MyMwwwkX49uZN1wvrXVsq1LCQt76G2ssxjFiAeK2
	f9Ngl20yj1AnbLSjaO6Exqh531Mg==
X-Google-Smtp-Source: AGHT+IHhL8+FGVqE4StASBbQK+GKPLKQ23yfz9Hgmvd2LAMDXMDbprn8P2vC98R1CoFtVfRzKgpmCFMI0Xgh0iwsAoE=
X-Received: by 2002:a17:903:40ce:b0:220:dae5:34b5 with SMTP id
 d9443c01a7336-22541efb4cdmr39008075ad.7.1741560148625; Sun, 09 Mar 2025
 15:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309175712.845622-1-trintaeoitogc@gmail.com> <20250309175712.845622-2-trintaeoitogc@gmail.com>
In-Reply-To: <20250309175712.845622-2-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 23:42:16 +0100
X-Gm-Features: AQ5f1Jqgst7XV7vDFnTu5PHtELaWWv-jNCRhML8CSo8r8nW_p3QtzXA0mVyC9qo
Message-ID: <CANiq72=LwF0_ozgWLMucQmDg7o_vz8XJWHqSfWwE7-amhjCsvw@mail.gmail.com>
Subject: Re: [PATCH V9 1/2] rust: module: change author to an array
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, lukas.bulwahn@gmail.com, 
	ojeda@kernel.org, pbonzini@redhat.com, tmgross@umich.edu, 
	walmeida@microsoft.com, charmitro@posteo.net, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 6:57=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> -    if let Some(author) =3D info.author {
> -        modinfo.emit("author", &author);
> +    if let Some(authors) =3D info.authors {
> +        for author in authors {
> +            modinfo.emit("authors", &author);
> +        }

I guess nobody actually tested this... :)

The `modinfo` key should not change -- we want to still use `author`,
not `authors`, i.e. before this change:

    $ modinfo -k . -a samples/rust/rust_print.ko
    Rust for Linux Contributors

But after:

    $ modinfo -k . -a samples/rust/rust_print.ko

Anyway, I am considering applying this one with that fixed on my side,
but also, to simplify conflict handling, it may be best to keep the
old `author` field anyway working for a cycle or two (undocumented).

Guilherme: if I end up applying this, you can still send the second
patch on its own, based on top of `rust-next`, i.e. just the
`checkpatch.pl` one.

Cheers,
Miguel

