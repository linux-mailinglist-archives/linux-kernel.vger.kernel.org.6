Return-Path: <linux-kernel+bounces-343181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D904989788
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD2D1C20A28
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E5B16B391;
	Sun, 29 Sep 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="epL8BVEk"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1A1F94D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643790; cv=none; b=K+CUu1FtA0kqxpdDpiSMoAtVgSoun9aFDHkMedUTWGoCpR1VSw7kRHfWOFCbYMx6lK4Ld2j7W3WBQQZ5LOXJUJJzcTVFpACjQ+iW7U/mxglDAExD3omuiQCF9NI7Y/xXhwh+/P6cA0RDSnRxcsAMSA0Vul/ngAWttr/T/Dyi9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643790; c=relaxed/simple;
	bh=0TXbBf1Imx3Td6KYXZyFDLk3bd9iodrCA/B/FjBVlh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mp8W1I1Q/uQoUuw5g6fmHTkbMVhR8BESHaf2ZdxoNCka635mLA7BUnLwBXmWMWrJ6CD4W1hlY1Tx4UJWmpjsuohE2KOXZ88qUevCKgwMziPKauGJbZ3dAqxxtkpzEm+mb+t98Cx9mQO8vG/0qWKt1mFkh7+sajpl5ZxoHsiavb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=epL8BVEk; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-68518bc1407so34635027b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727643788; x=1728248588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TXbBf1Imx3Td6KYXZyFDLk3bd9iodrCA/B/FjBVlh8=;
        b=epL8BVEk1w8590kbMgQNWkbVwaHExf7C+VKoFck3zi2kqhYG+jLHehqlNCvmW9EOyb
         Bn0ZwQKT8Tu9pYy/kP/cQM/ItuCX7Z86/LkunLIe6EtK76UqrwuZf3sndqxeg69k61SA
         PTda4+b5S73BUJ855KqpHRoOPEPdDY5jeW4fGpa/PYVXL+kBwPYK3mMhtv9Z5QAMrQCn
         Y1iNWpmkCtpAbvj544FAuiaH5Zgzigw8Ci4IZacRyNan3Kgrt42ufcm1NXrBCCyxN1VL
         tNovLt7j4B3SihftevpZqTW57Zp9JCkq6mm/d6vO1kOSZPx9LUxNXj0jjeBIea+7ZJ9N
         50Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727643788; x=1728248588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TXbBf1Imx3Td6KYXZyFDLk3bd9iodrCA/B/FjBVlh8=;
        b=duCiqZfuXXSJIqk/KIufr58f17kSo4XdkgZpqQsPUrVM1Mo1EesjhfNLwPH6dCje0W
         MC1Nl5y/W6xgmPsmi3CbKbKuDGRbBki77VZt5a57DaMCk9is/I44yQJaz4aCbTgpxotn
         ke1qqfKH8XDiY8ejK4nvB56ICbMmg+xeRhVY/KF7+q5a0lxcTbP1WRLE7hAcNXRdK/zG
         m5j+qsjPjRH7HJNaZ33QFpPReUrF3FKdEX8/dmfym//IshzbShECsV9Z6RDQvAhgxokP
         Lyg77M4uh8G53zRb9FMgOqH6fTi5tX82C9AlXuziN7DvNicbdHPdJsWoBsO6gMGhmhXm
         BA8A==
X-Forwarded-Encrypted: i=1; AJvYcCVvrQTBs5EBsTeMbCXk0Ngx7/+U8A7RPouKTws5s5MnKzziyl1olohsO7x8B5eSionFzJETuywydyrTUBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Gun9OrIih6zPIXvEvyelzQbiZlfFflfPmNBIRaVgPLI1TeK4
	kgVy9BaVUvt6BoXxPJ6L+iuIRRTkLIturYZYN20yETuGe2JOs5KdLfrwzqZC0oS3KA+6C+5pAKg
	S0+U4MZqsFTum/44kg57qIVRjOWGpDqeHu18Mvg==
X-Google-Smtp-Source: AGHT+IFMGkBzz/SyirbbBicEQiCEDdlE69dd7HQlE0bRpTLL7qi430Yjizc9GEL10Kma/D0byBjMuTTe379MPpH4iqQ=
X-Received: by 2002:a05:690c:6381:b0:6db:a7d3:6410 with SMTP id
 00721157ae682-6e2501b1b7cmr66633147b3.44.1727643787839; Sun, 29 Sep 2024
 14:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213041.395655-1-gary@garyguo.net> <20240913213041.395655-3-gary@garyguo.net>
In-Reply-To: <20240913213041.395655-3-gary@garyguo.net>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 17:02:57 -0400
Message-ID: <CALNs47t9xTymmFnwhUDkHypb-ftK+ukDrcGe_80mKyv6cr6StQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: map `__kernel_size_t` and friends also to usize/isize
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Finn Behrens <me@kloenk.dev>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Currently bindgen has special logic to recognise `size_t` and `ssize_t`
> and map them to Rust `usize` and `isize`. Similarly, `ptrdiff_t` is
> mapped to `isize`.
>
> However this falls short for `__kernel_size_t`, `__kernel_ssize_t` and
> `__kernel_ptrdiff_t`. To ensure that they are mapped to usize/isize
> rather than 32/64 integers depending on platform, blocklist them in
> bindgen parameters and manually provide their definition.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

