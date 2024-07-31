Return-Path: <linux-kernel+bounces-268988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF836942BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E071F23718
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB01AD3E5;
	Wed, 31 Jul 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+5smUpZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AA1AC44F;
	Wed, 31 Jul 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421783; cv=none; b=HPPbeN7LwLwtnLtECJudjDWPDxVCLtb6N/wi2Owj+V0T3GVXczWCGS2Mpye66i+PAs/cQHrWYpn8+7vh5pLB3n+jyoXAs3zX8eySP6gbkrToVjlenOlsgW1GJswU1PTNBeWniGSYRABOawzBa2r0wpBpuLNWrneN+s+hSx1ijIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421783; c=relaxed/simple;
	bh=FQKoFJvy1J0kZ1zvxPLIXMyfB3bHK7DfHGPCBHclF8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxGATt+W+Dr4G4oNVtfruG8oMkX4av7qmgH3VuLi8aGqV+zzN8UEgGQwKgQETZLkZYFODD59ShBn+0GoPgh2RZt3oMakSMrE41PDBoyoE+SPb4mIldo9VEe+31AHoek8ETYFSv6mI3JIVVDiJ4jYZhAMHcYyxR8KsEnmzwCp13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+5smUpZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc569440e1so49997035ad.3;
        Wed, 31 Jul 2024 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722421781; x=1723026581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQKoFJvy1J0kZ1zvxPLIXMyfB3bHK7DfHGPCBHclF8s=;
        b=b+5smUpZupb+ujqjDFRtfAK4NNDah0K2lFXz+3q/Rl1lRHcXuUqwmXJzGTlW4Lgqhl
         ND0ybrob5sRmPPjc/t6y0XW232Gbv0Zj6i/VQfLrmU0x3rNOiqByLN8UlSNIvlghzy9Q
         UYpnGmykth2dIMmGoiJkFpH+Htcy/FSAP166NRddiCx/UiOoeYrNMIO5NqKLjSZxMcTM
         LnHfPmJQBSMm1urU9Dx4vEzMd8sKHXFS3NqTmPsLujRt+iVHqVK7vDz7/lOhjmeUcmex
         OL5cAD5R2Ay9q1qnMpZ6ARz/WZ8G2lwKzP5zp8sK7RgO2Dv0EN0x+T1o/0jpvezDB8lK
         gPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722421781; x=1723026581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQKoFJvy1J0kZ1zvxPLIXMyfB3bHK7DfHGPCBHclF8s=;
        b=l5FMqCLlhlDhpqCaE0zPQ0iWUvkLO+vXR3nxo1zwLMREhx0OEJ3VlHBfLff/73s648
         4Dw1ww3Paco50sedvNh6WM92H99j/3i+9whu0+nO74LGf7IM4p2GZkcYQUz3KkfsJhS6
         Bhr8GMJcBLEXfDkPW1+fT6Rbqt4VR5RddpJURB7hlL3s5+yrpaqMU72UF2itFKvsq8Lh
         M+kijHIiX2/ml02hS5UNSQGBSKS1vAlPYXEBG2MGhJpu8fmCQho8kkWMgCa3Mi+43MxH
         3aIg3myxBgTAX2HMwRSMyvcydillpuGArcuAwICZKsotY9gFSfcVc2FKhFrqbeMGUrH2
         Gn/A==
X-Forwarded-Encrypted: i=1; AJvYcCVuIX6Unq9xWadKj8RKwPWs1G9/QWwDmO0dGMYn4EhQaAD+doz5i4gPIt+P7Jsuz8KUMvvEGcExjAYzEr1Q2Ioni8JWL/SVQHZfadIr
X-Gm-Message-State: AOJu0Yyxo8hBZk7LvXGCJVJ6OnpEvZ+K4V9nzufIx+xAh0hiGJ13fAiF
	5721CQ7SGp34VBw42GwM/WCJ69c0EvnYbrk6jx6Pvii0EcxNzEwWA0I/RcQ3g/cHzpHnON4RLir
	rj31Bpc3o32oU7b4mn/XWhtVA1DI=
X-Google-Smtp-Source: AGHT+IE0NflDpeVCQ0wq+X8dhvb52wtmDhcGufHNYbZ38cgvgpr3oUijLRTumr7kQOgnIkK93CjLTg+jjMENYGiyclw=
X-Received: by 2002:a17:90b:4c42:b0:2c4:af69:5c39 with SMTP id
 98e67ed59e1d1-2cf7e1c1adbmr17713599a91.13.1722421781375; Wed, 31 Jul 2024
 03:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731032030.2847151-1-neal@gompa.dev> <CANiq72nXN-pkHAG6A19JrjiL-uKpem_-8GN8RhiVgc+sKJN6wA@mail.gmail.com>
 <CAEg-Je_S8hAUg9Gdp7QAOxww2dvV4_OoCTV1pvxMNAAvVkQueQ@mail.gmail.com>
In-Reply-To: <CAEg-Je_S8hAUg9Gdp7QAOxww2dvV4_OoCTV1pvxMNAAvVkQueQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 31 Jul 2024 12:29:29 +0200
Message-ID: <CANiq72mibFYOpQY4RxuJf1DQAdqnAsuLW2-24MnY=JpdSoXd5w@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: Only block on RANDSTRUCT for RUST
To: Neal Gompa <neal@gompa.dev>
Cc: rust-for-linux@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:18=E2=80=AFPM Neal Gompa <neal@gompa.dev> wrote:
>
> When I originally wrote this patch two years ago to get things
> working, Fedora used all the GCC plugins, so I was trying to get GCC +
> Rust to work while minimizing the delta on build differences. This was
> the combination that worked. We've been carrying this patch in the
> Asahi tree for a year now. And while Fedora does not currently have

Just for clarity, when you say "carrying the patch for a year", does
that mean Asahi used it with the other GCC plugins enabled?

> GCC plugins enabled because it caused issues with some third-party
> modules (I think it was the NVIDIA driver, but I'm not sure), it was
> around long enough for me to know with some confidence that it was
> fine this way.

Same here: I am reading this as "yes, in Fedora we tested it for a
while with the other GCC plugins enabled, although not recently".

If so, that is great to know and we can relax things here.

> This was mostly because I wanted it to be clearer. The negation didn't
> exactly read to me the same way, but that hunk can be dropped if you want=
.

I see, that is what I suspected, but I wanted to be sure I was not
missing something.

I am ambivalent on what reads best, to be honest, so I think I prefer
to avoid the change if it is unneeded.

Thanks!

Cheers,
Miguel

