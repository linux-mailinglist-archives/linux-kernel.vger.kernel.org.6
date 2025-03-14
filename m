Return-Path: <linux-kernel+bounces-561281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8FA60F96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49E83AB33C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7B1E5B95;
	Fri, 14 Mar 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRbT6rnQ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BA1FAC59
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950443; cv=none; b=O6wdFH5+vjGo/4mlt+6gDo0iyFs+xs3lCEGgsChnCDtLv5ShwJTRTuD9p5SzrXcssyBaQ5HKooKc62KBpbzyLRiSCaIeu7yJsX0PPow4h0fosBXOmfB94UU05xwQsvsiLVogSvfRewOjk7/xlKPVZJ3iKcgK7SGXUKK8zQ3ijyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950443; c=relaxed/simple;
	bh=vZi2jP0lUPybBYEbDuYNmDxbGVhPNTPD3/wL8bL3hhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoIe4Z5N0vPGRx44s2Rfti/DjKGcz1frIaCEv7yuHZlyBo1Jq5M2DxvJJTUk8gDSrKasXwREb9o0S09BdnH+5Xt+hKLjBm0zvVAWEcz54PxmrmDwr9Qdpgshhz4i8vMycaB6XupbY4KXerToXWrYuQD9QEdu2CKS/TAxAyeOAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XRbT6rnQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549963b5551so1934490e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741950439; x=1742555239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZi2jP0lUPybBYEbDuYNmDxbGVhPNTPD3/wL8bL3hhk=;
        b=XRbT6rnQ1I33ewxkLDdpOOgjOnVLWLzLkcm8yxXvaKji177ZoUJGyvI3L+O16xANoS
         ET1fe6A+kzRloiMVNWgpPOkp/+sitixwuxvIdQ/75Q2L3hg8f5GBfJiXSUnFmVz43FH3
         Cwxqnf8PzWMw0TH3FB1SnPFikaPDKyUb6AuB3mQTFUt7dAhRg+5m1cZSuxz6GrpbqYo0
         Cwep9jYZ2bOO0klZ0XtO2F+MozdxSV7xH/tpn4K8Xrwme5aHCZq9StRGBGjFP7i9tcVm
         PNeLZfDFH5blmtziZL+5yHHl9im2egbZR1Ws5267ZU9G0BfJQ5JfPwaVGz7XVikU9rBf
         X8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950439; x=1742555239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZi2jP0lUPybBYEbDuYNmDxbGVhPNTPD3/wL8bL3hhk=;
        b=HiaDsi7gWPJJZkBPTZe9hj1uLp1MhImY1WG/qgl5W1uGPizhkAUb3qC/UIzh9o3M2S
         UmJZN+7Iz4+zun6SCiH5E1jsPms0bJ1LKJVeZ++n2MSv5TBKDsm3czs1IkpYkfJIcKKG
         Y174v/OIMDMqdNGHKPWGCq07kIdDx86XNudbCVA+JFB6NpCbEWENEI/rFIV9XsyqMgAJ
         nrgzwYz98cCKFilL6BLZ6HzTuSery80jjHmEUdfbkOOEvDKzaJWr5IJduz0RB9iuZTDj
         ihIUkKT0ZclRZF3YifGaOqMQGuOh8XY5seG9XJ+1SoHw7MYxuR9LW19/02mn/AJu/eNq
         X76Q==
X-Gm-Message-State: AOJu0Yyg3gcCNEsb1CUhrjCOMfiDT78x7s0iLyv+s8GTMc3Xi5iAShXB
	cQM3bzv4G1GmpDoBkx1nLOHt1PoCyQMBhrLrgC/JsJWmf6uVQieil/XFdPJPzvBioqsNEzlw9tS
	O0EvCxkN+EcVVwECXPU5QJGilz6XgMpEX0ljXHA==
X-Gm-Gg: ASbGncub3XFKOtvtzC3BTHZ0B5QXdnQ+gnP3m6gQnj1DgXxsCsAJfL1+h6ZZj69l1HH
	ZXEqqkDuWCjWjbXOod196T98TR6zq2q4j38942eqGWBqf7r6ra/nhLtJIECxbNJQUJuKP7x64Sk
	+tP92DrdOOEzPI4qOgiRvPfns=
X-Google-Smtp-Source: AGHT+IFcSJixnoEkwjBUQViqWqnA082lFxNmXc+zDCN3J9rinIe1fmSsbkJHXctBWaopHE8b2FJcr+Xj5vpkvUqtL74=
X-Received: by 2002:a05:6512:3b90:b0:540:2da2:f282 with SMTP id
 2adb3069b0e04-549c396e64fmr616002e87.42.1741950439299; Fri, 14 Mar 2025
 04:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313142404.896902416@linutronix.de> <20250313142524.262678485@linutronix.de>
In-Reply-To: <20250313142524.262678485@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 12:07:08 +0100
X-Gm-Features: AQ5f1JoyhjvS7zFo9QW7bazOqObF1OBeqJTSOJinfX79D7Z9kBdnTxqrbBSnBCc
Message-ID: <CACRpkdb-=VdXDMwMC_gdnbXOQjKbexLv7RTsHxjuywinxd57eg@mail.gmail.com>
Subject: Re: [patch 5/7] gpio: mvebu: Convert generic irqchip locking to guard()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Talel Shenhar <talel@amazon.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Guo Ren <guoren@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

