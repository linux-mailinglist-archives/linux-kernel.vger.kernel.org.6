Return-Path: <linux-kernel+bounces-311732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91B968CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F31B21861
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324A31C62B9;
	Mon,  2 Sep 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYN/5uQY"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9B1CB508;
	Mon,  2 Sep 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298780; cv=none; b=fzZ8/zY/B/9dsRWiFcLmQGASiU6VpHGBaXSHzp8NLrtkm/UWyCqFwVFeARfxoiwCd13hPcIrQorCqXKNKm9InoPP//fVtJ5SdHe6Z6W8t7Ec/EPsFmiy64LAyuLY7pW0JUvq++0TlviezrJ28NNRhe6kWNimWHcIPv4RVjXRVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298780; c=relaxed/simple;
	bh=vRsL+CTH8FgQo0m3Ab3RyXO5CQ+ueXWSiw9o0pGnwFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H28rEGrgPiWtem5S/45zfeQJcWhw/Kw5mqWCuTxcyor4ORUbWycGc7plOsHS1iIARPJXvnS5gFwO9N48XUu3dpThdSRrmrVmSzgSTnRsNedNNFNGnSax3Msyt+I+Ohxh70qtHPkNGz8NvzfCuThX4y49VZuckZi6pI9tVo9lgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYN/5uQY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d4750be8c6so737426a91.0;
        Mon, 02 Sep 2024 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725298779; x=1725903579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRsL+CTH8FgQo0m3Ab3RyXO5CQ+ueXWSiw9o0pGnwFQ=;
        b=DYN/5uQY33aLHWJ6idmNrdW2F871In1UNr/e4oFq0ISnWSx1aqw08/HwC9SDsj5V26
         ylLYg4JEhtZLoZv7oNLrWePYioXSvKTKF/RU0EZxZPOVyNFduRAyQwZhE2hYazKqfjXw
         Pu8cSTZscCw3e6mM0eZY+TKH71hZpvLdcw7BfJdJSVQesDPzhWQOlAFB9/ygZ5CtwSZH
         WH+YYrtcIXKJxkaF9bg+IKnZujQwnbvGr+jWPcSJ2GBpnBMST8ZRRRZZ8sAA0qPBJd9r
         wmd5yMySdK/BB85i/mH8ScTSQ2MRlEIJ8+U3e5MeA8qMM/Q8D1wbIgDPwjd3g4L6U1Uu
         8x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298779; x=1725903579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRsL+CTH8FgQo0m3Ab3RyXO5CQ+ueXWSiw9o0pGnwFQ=;
        b=w/yEC1aKpHC15pUMfaZEPrbBklcBZwBmzw/93pCVhH6xtVMm/KtoTVBU5sJZ/BfRGh
         ToCNYtirET5fj5D4erIaGP/X+QWtsmOj5b99Q1rc4qpQE5FeA8ihwu5eqEXOfXHRkZuC
         LpgTkYMfTGsNFVBDtnoTvstG0CmxNJqSmm/3erDc9VuAO80dBNMWvfZcZ91/Inh1iAMy
         JaQoYjQmurshswjTaZdUm5GB9Gv+LIMVFk6sbtqIknRLr4uFcdE/HSH2sMkDJ4LwTWNm
         4GYV9EBRKTsYR056sC+t1qvTep2Vc3YkRN+EvgATzggjUuV2tpit9Hum7HdD6rfQSBKS
         SMIw==
X-Forwarded-Encrypted: i=1; AJvYcCUEgFRnqJbzWlauktJZm9DYYbwZEelyNaKTUX91lhKoyXAWOt9zzURznOmcast4WjY+CCs0v69WmsBrTaU=@vger.kernel.org, AJvYcCVDDeilWegZij94bv8rJzoAsFl+4+2m578eACZXygXvGegJvlxnIo+FaHWUT8aZDwQepFJlCTxaLMfELV7udEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIyHsboRx+YkF52DmdRBQdEOSYzGAeBCKQ6fWPesg8b6SygMUo
	Fc6MaYri8zWs1pPOgS3dbuzAaOCgubvTeY8wciDGYKRLWhCrsDwOcTSE3f7QoDDHOBFkyVFNC16
	1W2OVMlvoyLaWs47FNKgU4ArQWOE=
X-Google-Smtp-Source: AGHT+IHMbFVypuwpNLgzoZNYwy/0pWWu1+U7M+48C1DByfr2vsGWPNCJMV/6P3ZmCAweLqH3SeVl5Zd7y/J8Mrgy93M=
X-Received: by 2002:a17:90b:1d88:b0:2d8:d736:c35a with SMTP id
 98e67ed59e1d1-2d8d736d451mr2343394a91.3.1725298778681; Mon, 02 Sep 2024
 10:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902173255.1105340-1-ojeda@kernel.org>
In-Reply-To: <20240902173255.1105340-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Sep 2024 19:39:26 +0200
Message-ID: <CANiq72ms9dY-7ZKCs2B1t5nwvkDVbo-7iAPcmKn-xzFUiZCVNw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Trevor Gross as Rust reviewer
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 7:33=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In addition, he is also part of several upstream Rust teams:
> libs-contributors (contributors to the Rust standard library on a regular
> basis), crate-maintainers (maintainers of official Rust crates), the
> binary size working group and the Rust for Linux ping group.

And just at the same time as I was sending this, Trevor is also now
part of the compiler-contributors team (contributors to the Rust
compiler on a regular basis), so I will add that to the message when I
apply it. :)

Cheers,
Miguel

