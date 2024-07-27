Return-Path: <linux-kernel+bounces-264216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C1993E045
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A782AB2167D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F451862BB;
	Sat, 27 Jul 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMFo93+L"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B440858;
	Sat, 27 Jul 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099946; cv=none; b=GDyCvfsWzbT5dlmJsNc4RdZtNqOr8f6BCGgElTKQgMBJqlgiEPVFEYrWmzClWMvt9U8RrMdF3jOmyLFwetvTAJZE+h/d/BBWH6ge+kSX4617S2E0c5qb5b+Vl1qlhxQnAulLN+A1tY7nQiX/tJtXnfS+XsG8GH+Nkoh+MWNfpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099946; c=relaxed/simple;
	bh=TnCu9moS/HorySHWhgNVicYd0K2rbQwy6snP+4wSHC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFdn6wJpGxiwJeQZr42qLViXSYxgjRxpQaX17xCZLgjQgqxa9yGkh85FzN/wFWgAaUZjD+PZfWuiWc4HJWjWAKFGDu6OgmiLYnqljgS9qOA1dEmt2XjkVJsRUG80ExfwvQuud5Ez6FOODVZE9RcJMzXGU+dkm+sH2dZDUQkxmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMFo93+L; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fed72d23a7so12911025ad.1;
        Sat, 27 Jul 2024 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722099944; x=1722704744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZe1wXH4s8+rulMA3u8IwQl/StQ6I+666zOcnxFmrQc=;
        b=YMFo93+L+CrHbilZwa3Oc8ec3zC4qUVQ5BwoiRjBimk9k4rGxv95Dk0ifEVIrgxQIb
         bj9jwdC+e2Jok1S08jZFIBpesq8lf/ZAgDNy64Q2rwbkk7DBaXtzgFycCWCzSWnJ6WvB
         /vD+XVjsryxERGlCebYmNB3tOaf6W4HQ7g9IkGlJOlLwXI5vY8ArUoNFM2dn44srkF35
         X+7hEdnF1LDdDPvBJv62Dpu3yUkqGKqB28bM5Icqg4wTT4J3c4VC2sQk0GTyo+ve4666
         e9+RFnSMo86GadO1i0MSAhbUlikHcr54vf5rN7NmgwnrKYMwHDCBOpFQq3fhizoyC5JC
         w4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099944; x=1722704744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZe1wXH4s8+rulMA3u8IwQl/StQ6I+666zOcnxFmrQc=;
        b=o67vVljhNDg/+6nhb/iPYHGT3kDh59tbaNVcTSgNttq/7WasPslE0/UE70G+hXzcrW
         j1KAGrCNGrSpBoiHee0e5oh34HSUAB9OJEKxMSEEWhBmK2PjrJ9kdlP2KmKw0oT0a2Nv
         pxTIU2Yap4ePuvoJ1sEC1brsE8ddV//TgNFklVtvA+/VKoS+mtffYDW0YVvyW/EmEatL
         ceNINNdeLS0tY3tzpyeTU/73nbMRacy5SpCGsD40nonRx0HI+rhtfUS2XLWFlqJBo3SW
         BEohv6IQHokmHVGXw2Oz7uE+1Gok7fxxBeS3Zt3C0Z3K0ssIo2xCTA5fKYoB8mJoLhvg
         kwlA==
X-Forwarded-Encrypted: i=1; AJvYcCV35sCWrpsklAlvnz4RQgXvxZBZQvUkzfpAm0+0qxBbQw8QzUH1cMfU8dIm5Mb3heZktP/A1j4Z2tP/eMGSbZYoxPt8reFo3nnljr2esg3ZjSRyiOltAVW9Yqu0504QYooHeN8LrQ5iKmmWues=
X-Gm-Message-State: AOJu0YxSH5RECLaDp/YqQk/BHF7S0qzbEyTJdyoYvAC79HVjNvoszhvr
	kx1e4crHaFECmYgGTmTnM0uJ3Omx87cd3Hiz53t8R90lftHZ7kD1IH0F8dC4vwVFbaN8Ip0DZVI
	VtlMYAW58PPvvSyxrNpQrgsiUrX53roxG
X-Google-Smtp-Source: AGHT+IHKvdQmiABkm3wRO+DcP9dkEeqepdUadcqt3wcfZpJjD3M5maaRgyRgGkWZFA/p+/qSy+CCE8fvZ5HNFLg5BZI=
X-Received: by 2002:a17:90b:3b51:b0:2c9:7803:1cf6 with SMTP id
 98e67ed59e1d1-2cf7e225e16mr2732823a91.20.1722099943734; Sat, 27 Jul 2024
 10:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727140302.1806011-1-masahiroy@kernel.org>
In-Reply-To: <20240727140302.1806011-1-masahiroy@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jul 2024 19:05:31 +0200
Message-ID: <CANiq72=4vX_tJMJLE6e+bg7ZECHkS-AQpm8GBzuK75G1EB7+Nw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 4:03=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> The successful execution of 'command -v rustc' does not necessarily mean
> that 'rustc --version' will succeed.

+1, it could also be e.g. non-executable.

By the way, I was checking recently `pahole-version.sh` for a series I
will send about `RUSTC_VERSION` and I saw that one has a `[ ! -x`
check after the `command -v` for the non-executable case. But taking
into account what you say here, I wonder if something needs to be done
there too, e.g.

    $ echo 'bad' > bad-pahole
    $ chmod u+x bad-pahole
    $ make PAHOLE=3D./bad-pahole defconfig
    ...
    ./bad-pahole: 1: bad: not found
    init/Kconfig:112: syntax error
    init/Kconfig:112: invalid statement

So perhaps we can put in pahole-version.sh something like:

    if output=3D$("$@" --version 2>/dev/null); then
        echo $output | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'
    else
        echo 0
        exit 1
    fi

i.e. similar to what you do here for `rustc`/`bindgen`.

> However, I did not understand the necessity of 'command -v $(RUSTC)'.

I agree, I don't think it is needed.

If you want to take it through your tree:

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I can take it too.

Cheers,
Miguel

