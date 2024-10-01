Return-Path: <linux-kernel+bounces-345836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F0698BBA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A180281D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA41C172F;
	Tue,  1 Oct 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+p3vyia"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AC1C1725
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783769; cv=none; b=mX4327EVg79zETOcwWzBh4ytYP00XyoABUQBU9zjge18kakiUcctJgCBOY+QVL61G85QqdFsfGLysMmj7+oTIT4hBCH8htp+edS3zRJI96qBhGIbWoykkgP++uljtoqclQFsYgZHaCiOh1ZfBunmLnxHhLUp/r63dlazHXb8Rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783769; c=relaxed/simple;
	bh=dCRCTpeBWVQaEGezuqoGfd4YJh6Ew8r8frfM+R+vKoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLJh8UHhhRst8HcsJpbP7eHaIlFgQVDxEqnK9kG8XU5dc8bDjBQIuJDg2UwFk7v6e5v/1zsbBh2cNCIuDCP2Upr6AL9ChmF/OGJvOvFQUXA8g+8O2UoBjwZ8QPjoHFVoBT3kXAqKE9LKeMZqsi1xlPT0BbOstpAjjJEoW8OmfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+p3vyia; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so6603519e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727783766; x=1728388566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCRCTpeBWVQaEGezuqoGfd4YJh6Ew8r8frfM+R+vKoM=;
        b=A+p3vyiaUcwV8qih0p8dTFOlKzyp5Ax/laufphx7Ku3mjZv67zBcY1qKGQeJy7LzdL
         Xq0l8GT9QCmOsjStnqS4klG1vQNLUrkyLaK65cjqxoXsE4Rhl6lF3NYGCtQDyicOjbiO
         LqNkpTrkQ+0t0YZhNQOvkBkKLDunJJ65zHc48WPyxV4ifkRJ3uF7pnd9sxmYcB8GmwKh
         jNUxY36/h3cME8T8MohnExoM/aAZiB3iYfvRh3xlJ+kxDBdzn7xz4EFTRtJNsNvjUgJv
         RpImdvzI6FscgKI4IfgpZjZQ/wvoHU2fVOXQ63XbN+Thv2Hsl9LNIJ0Ep1nWqfC+wTBS
         M4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727783766; x=1728388566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCRCTpeBWVQaEGezuqoGfd4YJh6Ew8r8frfM+R+vKoM=;
        b=JIY+UJ7GX0RjYYquZeW11Sm/AyIPavAUDl1B2idPVLH44Fe+ZL9bN3DUkELBed215c
         tfEGcWETwZHdO/bovpgBI+pmEjWmAkLjl592r4WeaSb+s0yvyyF5C64kvlvehA403qFd
         EupaDRE6JjpcYKZMRZYcIxxabn6ejZ4oS5nLrFIvK9Tlfk58AcQ+MhMyYwhOvLFPRQRJ
         ozH3kGwa8MbFWJgUZ4YqLYtj/wgKEHe+0H6S87z8do/QUHYIuCMi7/hY7zs7nZDfZrnN
         ngfMYwUVFZFRKh7JVrfc319mVvMWzgL4ltHUY3acQSJ6ZfVW89ppuC2lDSiocn90eyjy
         hWSw==
X-Forwarded-Encrypted: i=1; AJvYcCXiN+nPj45KJt22Uo+HTwxGvaOG0Zb6UtuXRKj9WMg/T2XVRx5CIHJT0T0r4wd6/rDQ5Ti+v3FBjkG1hKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGbrFooNgSYCioQZtfGze0B1Xh77SUOmrnUZerVONHMmiRaoM
	naekqihpOsyfAZFW/63IisyuyFIHffUGQ/81HQNFYgsEunOtjqWmdISfD3OcMwL+66t+Y2vdmFG
	hSgdWvA9WZiyQzFWjy4KQl1UdaLLdfG/IHaL19Q==
X-Google-Smtp-Source: AGHT+IF671nYta5t199R7sRxpHHBTnmwujkmlr3MRg6tqyu/Ngc90gmiXkly9+05ccmQF2xTgC3WFKRZUK/UcnVIUxg=
X-Received: by 2002:a05:6512:1087:b0:530:aa3f:7889 with SMTP id
 2adb3069b0e04-5389fc7ff3amr8180609e87.56.1727783765958; Tue, 01 Oct 2024
 04:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-imx-pinctrl-optional-v2-0-bdff75085156@geanix.com> <CACRpkdYbOTXmap-vJy4JNZSaZnE=yzC35EPD2F=bD8gWdD8-GQ@mail.gmail.com>
In-Reply-To: <CACRpkdYbOTXmap-vJy4JNZSaZnE=yzC35EPD2F=bD8gWdD8-GQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 13:55:54 +0200
Message-ID: <CACRpkdbOUSS95SJxsZHmYfZtZNhDe_dy7OWZnsxe0WcExC1Wyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: imx: only enable pinctrl as needed
To: Esben Haabendal <esben@geanix.com>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 1:05=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Mon, May 6, 2024 at 12:24=E2=80=AFPM Esben Haabendal <esben@geanix.com=
> wrote:
>
> > As not all mach-imx platforms has support for run-time changes of pin
> > configurations (such as LS1021A), a more selective approach to enabling
> > pinctrl infrastructure makes sense, so that an e.g. an LS1021A only ker=
nel
> > could be built without pinctrl support.
> >
> > This is a very late follow up v1 3 years ago [1]. The situation seems t=
o be
> > unchanged since then, and I have tried to incorporate the requested
> > changes.
>
> What is the verdict from the i.MX pin control maintainers on this?
>
> I can merge this into the pin control tree for v6.11 but it'd be nice
> to get an ACK from the maintainers first.

I ran out of patience and Shawn ACKed patch 1/3 so patches
applied.

Yours,
Linus Walleij

