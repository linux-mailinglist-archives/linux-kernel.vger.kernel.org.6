Return-Path: <linux-kernel+bounces-310795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEBD968159
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596C21F21151
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9D5186606;
	Mon,  2 Sep 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KpRh+uVV"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7317E017
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264289; cv=none; b=jZOxYhcSTIvqmKGFvp9HZml7X/2Yut2yh963HOLElTo6JVNyTNhOSeH5uSNtpKU1Y2zUfrjsRtIosBzOVa5qvVycOzq07p7rZkG9VhCR1Qt7fJ3RNIzWhMl1A/GGOn1xOhIlnKrtWzcW/9Gm+1TpSPilA1F29ym6j+ClLCGzKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264289; c=relaxed/simple;
	bh=+UTkjM/YpFeicUPaHWpIAijZq8DD+lel03KrAl7Eqn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQKsaYVENqVuKQKRctOz38LD8rWpIuVJo2LCvCgzTMwP7wYCuF+SsSy1PxO6AIf/2bps+1w6KjS/9FMkQMbK74llb0/cuw2quB9gUaHKWZo75+42EZytbJVec2UAe4L0pRY86eMnZvDXzR7IgWEyPfgQlqItY5SSHRzmlv3r5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KpRh+uVV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f40a1a2c1aso36201521fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725264285; x=1725869085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UTkjM/YpFeicUPaHWpIAijZq8DD+lel03KrAl7Eqn0=;
        b=KpRh+uVVyE6rv3WYK/eXnl8mE6+ez2C4Cu9CukSxOFB5pSVO3r0UEPece1wwLiO1Qv
         JO21Lpg26PewAGKRClUfCAxkxtImWx2g8Zfo2b5MEkcHzD3ofzsjnO7Y3RbeRs2JyXvX
         fQFGGd6sJyaC7NMNVdlDq+ULQiripPIKOlI3bO9bqNui1T2ejw6eBCxqk43DB0tnEXq9
         984V8tMF/9Ovv5b5T02eTHdaKC2AwubMcCkwKmX3BbshiVux2XVytXHZHIJLG+nhCUjs
         tVgitYJzo3kQl1Xcp0TjvWDW25rD1N0MR1DzAMmh8Wd+e5oRtTl2iOKuEAiKsdufWX2k
         lYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264285; x=1725869085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UTkjM/YpFeicUPaHWpIAijZq8DD+lel03KrAl7Eqn0=;
        b=hjO3owteQstrhfGOdw1hSraHSm3Arm4ceRudX8j2WpMuIp8BXNiE+n/qSjzN+zMtqS
         O1pDFU9+5jz0Xz1/dqrAQQsqOE2Iz2p5FUqWrpw1EUg6BWf/utMUmJ2q6dcYj9LoCazb
         G0Py3YC+t5IzJVVqOyM8EF0svSQPFKWDKYOjYpGnzZYNEpjDPUjxGfY5FjuuCm5gh63x
         G8NFa255ochy0qi5+y80u17cDCZgQ+C+u5bfgjW9Qd9MGqXKmvFDTGqWFWe/NJZjziyy
         mYes5jGNV5oxJAi1VKca4Xrh4it7KNuZqZN0OhnHWO+LT8syiNBI9tbhxGexJb1jBntl
         2GIA==
X-Forwarded-Encrypted: i=1; AJvYcCWj3AfHuF82XI1CWfY2R7NrdbCSAsMESt0XsUXxdXRWal1Pnzr68LxjlpigJoa3UQigk+I9rst/kOmzrfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTudzyB9751n/gBdW3pObmJsJ+rGPS0zJuZby1K8uNHpPuRyPh
	06oZiIMIoftdT1zEL6x0yhek+QLc5Ce7cEBQuZ07lTg6Z92xR7vw3nyVsu9WfSHXxrGzjeGzlr5
	JblpLavwXSEeO0JUoJbDYQHG1DtpvTvKNAjKjDQ==
X-Google-Smtp-Source: AGHT+IH/2Sron2senQlaG+hNYCIf5KgSiTssWFHnzlYklHs8dJj/QIMBsSouj5aXuELLgPa/B5+9AnhJvxEmPM1PyIw=
X-Received: by 2002:a05:651c:1505:b0:2ef:216c:c97 with SMTP id
 38308e7fff4ca-2f6103a520emr84062511fa.19.1725264284861; Mon, 02 Sep 2024
 01:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org>
In-Reply-To: <20240528120424.3353880-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:04:33 +0200
Message-ID: <CACRpkdZqj7-mxCBBoWZm5QAVfNhak6PdrMnSmUWRKb6DpJLQNA@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
To: Arnd Bergmann <arnd@kernel.org>, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David/Jakub,

On Tue, May 28, 2024 at 2:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver fails to link when LED support is disabled:
>
> ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/rtl=
8366.ko] undefined!
> ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realtek=
/rtl8366.ko] undefined!
>
> Add a dependency that prevents this configuration.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Can you please apply this patch, the buildbots keep complaining about this,
and we agreed (I think) to take this dependency approach for now.

Yours,
Linus Walleij

