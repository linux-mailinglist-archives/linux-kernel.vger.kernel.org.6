Return-Path: <linux-kernel+bounces-240717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9689A927195
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E881F2409B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49901A3BCD;
	Thu,  4 Jul 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9eOHOlu"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB471A3BA1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081246; cv=none; b=qVhizlkRSyMZtaO+E/pTUet03OK6f3kxlam/+yAAI5oLIrOWPSSqgfjI+Gyyl9SsMIVjvKfscyKo3mAyJea0Ec5Zm3F4VQ+Q1w2fpesG+KQvwLzSUD2ITdtTjEqFQMd81QbXcvEI8At+Qa1PmOZU5DaMDjCa4V7JdbzwfnH9CBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081246; c=relaxed/simple;
	bh=lWxpE80jJmqS6sCZoSvNul+Utq90SiJ8cm8FsIPCszo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5oTsJAcB4ZacvaUslMyxy0rawIBcrTPPuhAuQ33aPWGHNFC2lM9NJBQ44ruCO1C1NnKfSdn8SYy+rypkr42lbt2d1zkksNQ4XaEKyOlMcdagWe+rFMzxTXOL+Y3dWy6icnmViZ3tHsjfNrCKLq4N6Vj6dDlHwJwRPwlTnf4PtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9eOHOlu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36799a67d9cso353404f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720081243; x=1720686043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+arIzU3LXYjgnA4ueWO0skmcvyTi9fBY5ba/c7i1+hY=;
        b=r9eOHOluJelwx1ZCdZ0izF6hf5o2N8eIT/irVMpi1aGDHlKlEH8KecwwjbFV8Yhwvr
         tacPZMLa/69qOWrqra2PJ7AhJUFmU8m5RbOogZ2OCKbkM9SyI0eCK3ct560ldMFrU1Dn
         5VUEVugNEjtXIoY/236/Ei6xzaRSZC16tHVdohCxjVSGyuD971mJwLTdWiLeZSGY9njw
         3E0uhq0PYMuQtaR/mgOYCd1lSNMhCbVLKR/Xb4eqOpPbptUwaUi7eYlCPeYJ39U98BOp
         AqCbn9ev3EEu4fg8r6TXcM3zYVl9sPuVVPx0OhT+hw0DeW81fZzb8CG8NqCSr+809e0c
         x7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720081243; x=1720686043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+arIzU3LXYjgnA4ueWO0skmcvyTi9fBY5ba/c7i1+hY=;
        b=h9LL4T8T6DAUBkca+LUUlXHEIWQN7A6hzzpu73TVGUDSy1kztmgPNRsl4GvW9CTz1V
         fC34B3fdEmNfqxEDjPKrSpsicRIf+7yAOlrNy6JxDSg5AAUb6EdkLk8GEKe1KQTVDBNw
         IoUJMS4TF7kLFf4zSE9bDpJJvdvBEIHe7Gj3W9ODsGuinkyatZa0BBGisT21+Gk0kFSu
         8KYIWSg5EoY8tFKYuoUJmfe7omQmjxlJVs0Q2Ufxqj1++b3oDG5tLdY7IkomeoubTMl/
         qeKXTRRYNo3O//MKF1T/hnC6P6JjbGW5ac+Ri9Z47uj1dO7RPwqT6W/I9jLu3VO7ysZ8
         Q2cA==
X-Gm-Message-State: AOJu0Yz8BgunUbJsvU48qaHhAnlHu+agUFixhvTOgijmer4vR0Jgy/OV
	3mihn+v6+d+1bXTDhi31oLfFyc7YxHmbWAcVD4x9492Y37LNar4Q0jM5DJSEsK4I2g4CA/EUH4P
	DMDQv3JduaeJ41uT9/9cKJqvSdj8gLeoXnhTO
X-Google-Smtp-Source: AGHT+IEUZz5voZk91pUyiEn2nST6nFZr9MCFzx9zPoVVjbBLSKdNuK1O5hinsYLKbZaQ20WAABfGIk7cKXNlhokMqg4=
X-Received: by 2002:a5d:5187:0:b0:367:927f:980e with SMTP id
 ffacd0b85a97d-3679dd71fb5mr857005f8f.63.1720081242517; Thu, 04 Jul 2024
 01:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
In-Reply-To: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jul 2024 10:20:30 +0200
Message-ID: <CAH5fLgj3z4TMnXz=zygLW9Fku6N6nX0jyw2b0uvg=Kat-d-o2Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sven Van Asbroeck <thesven73@gmail.com>, 
	Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:04=E2=80=AFPM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 71afdd98ddf2..9cc10e32e8be 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -150,6 +150,7 @@ endif
>  KBUILD_CPPFLAGS        +=3D$(cpp-y)
>  KBUILD_CFLAGS  +=3D$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(cal=
l cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft=
-float -Uarm
>  KBUILD_AFLAGS  +=3D$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -=
include asm/unified.h -msoft-float
> +KBUILD_RUSTFLAGS +=3D --target=3Darm-unknown-linux-gnueabi

On arm64 we use a target called aarch64-unknown-none. Should you also
be using arm-unknown-none? Or maybe the arm64 target should be changed
to aarch64-unknown-linux-gnueabi?

Alice

