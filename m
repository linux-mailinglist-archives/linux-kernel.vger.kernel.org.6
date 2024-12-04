Return-Path: <linux-kernel+bounces-431335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BC79E3C10
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376A1281202
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322E205AB3;
	Wed,  4 Dec 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIKoTh+0"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA614884D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321076; cv=none; b=kDUKlqM9yGcoVWNAR0GaGIk7v4GAo/ymrj7CyNqv6LGms7WDrfHiiVIxeJ1kmaW0WZg86W0uDpZMuauHeSYfnOkTZ6RkjDXxMKjuLo9AhVG1iCxETnR1OS4txcpOHh7xzG1srknHLL3DRaHIIAhQne9i4LAok3nNVd9K7E74qME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321076; c=relaxed/simple;
	bh=DSEDWwmbK/vXFGLFqFI1VqNrAH5oTLAjqf7I+1vOMt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVJDZX/bTLSXI+6hA9EXA/meONoQY3OdPqc1LPHzrObDkZAMaQQl3tBph8/6v7hzBoLYqX0vcwjRaeXNjJ2OtPN0kQ+/ofPrb09Ydk2hTnvlM/cJzv5qCWfPXreobKHNoHPdsL+yxguOiCPZrUx/xJgRjkNYp6VgkJZMR9a96ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NIKoTh+0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53dd668c5easo990968e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733321073; x=1733925873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJkZ1b+Bgh1Cw7S0YP/b9ztjzr/OipaCqC5BDrpRtNQ=;
        b=NIKoTh+0TQfuLeccxkIR6zWYOkwA8/q06lCkrc3q3+gmHni4zGKY/ciFMxfZef9HHS
         J2tLtYQnQLoQMf0PNfVscTsgW27e24biEyWAwT7UDPTYnv/FzvsBIU5bnuz3YKNMCLhS
         HaTVfEi8+iqBIVEeNNoUNRjk50eCBxD0gYtK1Bk8QfMp7c1mVsEZldGnGgQEvZpZLqh7
         m0Rz5qP3aCXCComCkaM2BnH1PAgCNzsu84am4gx4uJYfn3z/aC6bVvHuccBndGN3jyE9
         jpoyQifCxTdJJw9I6MGCbFXQ4p9rlDA3nOjTT2xiS5plYT/7IjQNtUEOTsVW2cZ7pY8h
         MPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321073; x=1733925873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJkZ1b+Bgh1Cw7S0YP/b9ztjzr/OipaCqC5BDrpRtNQ=;
        b=SiVbEyhT5/5S4X8LLHqxUXDm6YShcGNrVLxSsdvHYmuk1s89SU0HAwryI7Dyyxkt55
         Tqw5eOu+JnAcyzFDL56EjCCeDgnTlEjxTg6I9Uj8hHaFVS5HcTmqdh4D4yiwcLIM30yS
         e644HzJtx29ho9Wkwvh+r0AuIuWfCSdaWG5Q2MxpnyW5wDPTCkzBAp2acgF89mp6DqaS
         oLuRE7GgmIHOwjFXkXVYNU4092oMCImDymf8AeGZ8BCMkutmBp/sqaEXmp972tDdCo0i
         ipQb7rXj0Ow77kXcE0/+9cVzw2CYcwRvUt0ikT0MSAbd4qpwYvXQobIyj4DvVpPGOIUI
         zeKA==
X-Gm-Message-State: AOJu0YxtRigY13Wh6DKSWsfPuGuwfYDBdvV6Iyz1kFxm/wUaXP8tND4B
	lGQalF3eTpcdSDRs7Bfe+Y9gsOnuhx2tUBkJXVPSJOSYNh0D2l/qPLEN3LZkBR5ifZ5AlQd0aUy
	klIt4LwTlps/lPP9uk8fGaeqiqVifEu4eyayKpQ==
X-Gm-Gg: ASbGncvtfn6xEy09wXTVD72OV4iHr0qtoBSNNBSTQbzXmRjNdqRAG7lOxYqKJsdH1HZ
	DJGiUBeZQEhTORn1/okHKNyneajq/lA==
X-Google-Smtp-Source: AGHT+IFeNAy9KprAhgnIP+heCKM8AwjjL7AAMKzf4r/s9Hvqlilw63furRQM24t+dpERHTojSCrwlM3mqs/OvmZmpvs=
X-Received: by 2002:a05:6512:1108:b0:53d:f67d:d580 with SMTP id
 2adb3069b0e04-53df67dd58fmr8534117e87.2.1733321073129; Wed, 04 Dec 2024
 06:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-6-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-6-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:04:22 +0100
Message-ID: <CACRpkdbMjRbn3D5T26FtfUPN16b-3BMHr4Teak-Cd8O=iufU0A@mail.gmail.com>
Subject: Re: [PATCH 05/15] ARM: turn CONFIG_ATAGS off by default
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, 
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	"Jeremy J. Peper" <jeremy@jeremypeper.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Ralph Siemsen <ralph.siemsen@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Only a very small number of machines remain that rely on
> traditional board files with the ATAGS boot data instead
> of devicetree, and we have not accepted new ones for
> a decade.
>
> Most of the remaining ones are on their way out of the
> kernel, but the Kconfig option that controls ATAGS
> is still enabled by default.
>
> To reflect the actual status of ATAGS support and alert
> the remaining users of upstream and out-of-tree platforms
> with this, chanyge it to being default-disabled and
> add a dependency on CONFIG_EXPERT.
>
> The board specific defconfig files that rely on ATAGS
> are changed to turn on both EXPERT and ATAGS if they
> were not doing thath already, and the ones that explicitly
> turned it off before no longer need to.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For:

>  arch/arm/configs/integrator_defconfig  |  1 -
>  arch/arm/configs/multi_v4t_defconfig   |  1 -
>  arch/arm/configs/netwinder_defconfig   |  2 ++

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

