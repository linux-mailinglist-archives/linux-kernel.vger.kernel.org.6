Return-Path: <linux-kernel+bounces-299201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639595D175
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325772846BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2E188A3B;
	Fri, 23 Aug 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdT0DOok"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE0188914
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427173; cv=none; b=FrTjoQ19pYNLnLA7qbFf/fLbfrABTpz6QQy4bZYhq7DezKmNuuqXOhKlErFIGDyC/eyK2BZYC600FYMHm3N41SzegYFmCzzRumC56UMHnLwDz1Bivd7aWmAsf46Sjk7kQiamP8UxCx61fUm/7lou3/w9UCN9XdDYzsKnmBz4KBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427173; c=relaxed/simple;
	bh=9aXyELinQfYwyLATQYHkwQS0PD0DQrUrkpCY/Wkcr1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvAeItRtr2F6+IHvmCz3T4vwHs1GaDO+H4pmJy+RG7qN3apxC1m71uodm6w1kXo52NsUPZAXz99Hgx6W1RCoDArLE4+3Yjy3MIlYPZvKAIGTKY1BsL/SKKbqGrC2vvIAJZwyUfJgV5+gi18ddrMkzrYSI13Gs59niXtEygRXm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SdT0DOok; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso2581571e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427169; x=1725031969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aXyELinQfYwyLATQYHkwQS0PD0DQrUrkpCY/Wkcr1E=;
        b=SdT0DOok/1R2S3HMr8BCSjCFesI7pNklyEfTirJPU1Z641PMlbLjoLJA7BM0VPCviE
         DESgvjRhPlB4L1CYinYutRiTJTy/vWaOVCeaK7NktmCNI3G0inXhNuInHuPAPLss2unR
         Hk/nql9qejBBRpSq4huEWJaFEle0rMKdYZtwI8eSsAA6wcIb5y+jV95DUkW9fPCpmRnE
         Gy8TptnFjtvG6fmm736FEJYAvEcXp6w2LsYyCS1w4n+94EIwS4Qgn0TmhC5zIj1gTCmS
         aO5MhUVOgaZ6B2A/r9Fx0V2mzcUu2dUXPCslSiv45snGBo8e8JUkO/1Sl9kzN3MOzaxD
         luYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427169; x=1725031969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aXyELinQfYwyLATQYHkwQS0PD0DQrUrkpCY/Wkcr1E=;
        b=X0Jzr9C/QVkRs/KK/qGTYhzZFry4XYxrBASNASO8RaHwU66qcXosepOClj0KFFdWxJ
         zRPEIxwaGy4b09wXcT+wHjghGTexBYHhUGNgkDNYaaFygENnps7ZGWNeltE6aOulrCbj
         qIE8/toMI8TepvrCn2A5u3CSvV30erDpdihQvZShp4odWADD74jMUcRYBEPcLx3CYl4T
         5SZAJOfNkCEUQ97inw3VOktUCzRuWFkw8HzTKHlWN8w1s1tggImhnfCw52Y8BN2Pc6fN
         12auXGuFFu+0rkojJn573r5+joWXg41IFqWLW4JWH1WRQlk3+m4ZDJoJeSbLR3kjp0tn
         kvag==
X-Forwarded-Encrypted: i=1; AJvYcCVQJipPbRWQQFnCHtLyzxb8iTAOa4gQvwxP0zI6Qbpx2ykdswXOZUlaVux9GdSzCiqQ9UTjPKlYduBMS0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQeV09Wgib9Pwsjf1DoVRRnh4uEUxrIVXoxPQ8jS2aeyS5+RY
	09GIfl+YzWdhqjIjOGYQAbToB+QkK3h/qQFtj1PbDvubB+reC3VhQTyXftBw+ad1aQWjxmIvuOt
	vgN5YfF8TxJ2Hk/7KBdfGws2zmNpmou83M0B1MG79HW42CBCW
X-Google-Smtp-Source: AGHT+IEYxslfLVF7+4zGqGpVr0fUIcYeQYYcG88hw1QjYn1vbcqIzy5iBUMugSQ9ALglpqd3RGOJWBHD6ds7yHhxQzQ=
X-Received: by 2002:a05:6512:3b24:b0:52e:9382:a36 with SMTP id
 2adb3069b0e04-5343883b0c9mr2013199e87.30.1724427168328; Fri, 23 Aug 2024
 08:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b992862-355d-f0de-cd3d-ff99e67a4ff1@ek-dev.de>
In-Reply-To: <5b992862-355d-f0de-cd3d-ff99e67a4ff1@ek-dev.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:32:37 +0200
Message-ID: <CACRpkdZZu4i_DPx9hZp1NXBv=4YBvknrMdaKni1vDeHb5+_rFg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91: make it work with current gpiolib
To: thomas.blocher@ek-dev.de
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:16=E2=80=AFAM Thomas Blocher <thomas.blocher@ek-d=
ev.de> wrote:

> pinctrl-at91 currently does not support the gpio-groups devicetree
> property and has no pin-range.
> Because of this at91 gpios stopped working since patch
> commit 2ab73c6d8323fa1e ("gpio: Support GPIO controllers without pin-rang=
es")
> This was discussed in the patches
> commit fc328a7d1fcce263 ("gpio: Revert regression in sysfs-gpio (gpiolib.=
c)")
> commit 56e337f2cf132632 ("Revert "gpio: Revert regression in sysfs-gpio (=
gpiolib.c)"")
>
> As a workaround manually set pin-range via gpiochip_add_pin_range() until
> a) pinctrl-at91 is reworked to support devicetree gpio-groups
> b) another solution as mentioned in
> commit 56e337f2cf132632 ("Revert "gpio: Revert regression in sysfs-gpio (=
gpiolib.c)"")
> is found
>
> Signed-off-by: Thomas Blocher <thomas.blocher@ek-dev.de>

No reaction from maintainers so patch applied for fixes now.

Yours,
Linus Walleij

