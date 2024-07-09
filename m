Return-Path: <linux-kernel+bounces-246202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE65F92BF0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B5F282EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77719D89F;
	Tue,  9 Jul 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IWQ/Gd2o"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB8192B6F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541147; cv=none; b=EEuMg4j0dHNP4oxL5KNTQw2cuEE/RgRjJaMIUgOHxO8BskIY9tafHW0LNF8Z2WavohsoTlnhloFSs0bJgVO0G1M3UK/CamY8AaC2Hpg8h4+UisYdf7JFD95w5PvGFypJsISX2gWq0n0JH1b1Gvg9OKgLOJdC0gGhBxQCP1wCxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541147; c=relaxed/simple;
	bh=VF+yfPArG2Uya737SWlaNledFQMHHnudw306bPlIOaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIZIia5uRQtgbEA6807qk8Z3S1YiOw2vulRP7oEjfz1RhyvCsD939GRGqBiBV1uyMiRYdNpIAz9jEr2z0+tqkefLPAYOC7qCNLlMo3u+V0djjNfJAER5s6KhR+/48h7Ga3l78JldDxtSk6jUNSNaNPpSkq3o55/FTU21claDXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IWQ/Gd2o; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eea8ea8c06so26869641fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720541143; x=1721145943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfXk3fTEqlZPEPFJitKkI9Zinf/x9z2xgvf/3brmGeY=;
        b=IWQ/Gd2owi5B88xlvEg93GsAgKYsKQ6qna0P6SxS4VuwQUISFYR0JrK57mZAh237Aw
         Su6lzjgu2ZkNTr2iI935vg6yHxVskP/XOQnybb1qohHWuERkM+grunj+lSJe11yJZEmY
         6kv6EvKo9+Uu7ODpx1uGFvfFe4dOpahTacQ6NWMgtKYnG8UF9puS2rctXvUjeC2mtShR
         7GCt2pc+9yU7Ee/3Blb51KVaXjuDMbw1blbFKxeJoO6rhEj6S73EfYLyteCG9x9vPuSY
         cGg65Sc3seAUfXvs6cGRcAlebFAOxVNJmnMzu3FYXZfLZlaLlRLc2/AzNVdeAQr792Zx
         tEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720541143; x=1721145943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfXk3fTEqlZPEPFJitKkI9Zinf/x9z2xgvf/3brmGeY=;
        b=cZHrUBnVbwmniSfDGkS0MnLXz+FfmciQyqwIm0sznewQZ7c8uSNa4oYDXhholIYrHl
         FfdOmn+kp+LXA6zCLgsdXfsC5yZg3LqUeuksfMIlF89PdXVI8T/3H/d9frZUPiyye3O7
         Iy+gubDro2Vtt1i+hBSgaDpm5rkI95ZV4JwLuVhkpNOMhGosw0UdLkmB+aC84UgwKPjG
         /4A6ExXsMSbP4bVJjxE9y0/8WcAu/U3VgTaLS8MLGX1O0bPVKlf/02yNfR7z+hsy6O2L
         zmdeG9xYwc6hhk3tey5KAcLNJm3AotP0kSJF3A7jWc2f9QYgG2xtT/OW8dS3bkYEKbz8
         6U/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0nj63H9l6ThYZrpyRz4yf4wz2WUOJ/MNijih/lu0rArF8I2/rfrOFl3DowXq5LDVnw7cp5X5EJfmu8LhSRFIXhPqRnUF+ddTaB3GV
X-Gm-Message-State: AOJu0YwNpc3iEEMxjVavuyY+gS/R1LLxvvO8tNrm4fa/cy0z/RgIHEc8
	Jcw9pc5E0x/g3r636WCnt8m3XSxbeLhVyOl6yDHpkZ5R3kPi4pK14GaotdfXGLS6LCi1EXJJgTu
	E9rnOGmV80LNze2jXcVARztQe8m8s17mQfAozPA==
X-Google-Smtp-Source: AGHT+IGKSJVfXAisUe6NcGYCOjmc/g6+k+gV6B29QgDU0qUyMmPFcYA13AfVsIS1mqs4poXl9Q2EMviFQ4lfCIG8kns=
X-Received: by 2002:a2e:9097:0:b0:2ec:4fec:812c with SMTP id
 38308e7fff4ca-2eeb3197a3dmr18848061fa.44.1720541143636; Tue, 09 Jul 2024
 09:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709092354.191643-1-manikandan.m@microchip.com>
 <20240709092354.191643-5-manikandan.m@microchip.com> <172052434347.27822.16864713604407945517.b4-ty@linaro.org>
 <20240709155410.GA3589336-robh@kernel.org>
In-Reply-To: <20240709155410.GA3589336-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Jul 2024 18:05:32 +0200
Message-ID: <CAMRc=McwTgOjQrNtSVORWFS92tJA_G=26x-8E6U+=4qW0d6OWQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: gpio: convert Atmel GPIO to json-schema
To: Rob Herring <robh@kernel.org>, linus.walleij@linaro.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, arnd@arndb.de, 
	durai.manickamkr@microchip.com, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Manikandan Muralidharan <manikandan.m@microchip.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:54=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 09, 2024 at 01:25:51PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> >
> > On Tue, 09 Jul 2024 14:53:53 +0530, Manikandan Muralidharan wrote:
> > > Convert the Atmel GPIO controller binding document to DT schema forma=
t
> > > using json-schema.
> > > The at91 pinctrl driver uses "atmel,at91rm9200-gpio" compatible strin=
g
> > > to find the number of active GPIO banks and identify the pinmux nodes=
.
> > > "atmel,at91sam9x5-gpio" and "microchip,sam9x60-gpio" have additional
> > > registers to handle drive-strength, slew-rate,  pull-down to drive th=
e
> > > pinmux configs.
> > > The new compatible string "microchip,sam9x7-gpio" is added.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [4/5] dt-bindings: gpio: convert Atmel GPIO to json-schema
> >       commit: 337049890b8cbbb4fb527c58976ea19f4dc747a0
>
> Patch 5 depends on this one.
>
> Rob

Oops. Linus, I see you already acked it. Do you mind me taking it via
the GPIO tree to avoid rebasing the tree?

Bart

