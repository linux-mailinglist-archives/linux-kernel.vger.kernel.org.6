Return-Path: <linux-kernel+bounces-561264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5766BA60F71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239FD1B63134
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7D1FCFF2;
	Fri, 14 Mar 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eim0nK9t"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13C1FCFE8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949792; cv=none; b=IoKqG2q9K5/ADdmIa2t2Io1La2Daxa2TIR+TSBRjKiYHAmAsDiXqsQaWm+xRsdVOVGkroLmIpYptZBbo2cwq9xKBI38Ux1GuNUCUA5LLkaWF3y6TaxEdJGGv0my71CorwWSB2xbv8vTQqttVcZ6I0Q2+E0ObQssii2NrV7Abnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949792; c=relaxed/simple;
	bh=VFKCqYNBypZASUp5pMtBC6KobHZh44HrAoDmtFddJOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRXFaa+zbliZslmgUmtSWhbavKrQ8VUyM8yNt7tJjDAMelW7q35Sx1G0FgEqh/r8p+AovNEMHXZ9sEqP8UqVcsfSAyVQ5Murir8Y76E6EfAa85mxy5jBDPO6+pm2fDhpqJ6zXN+f0DMD8N8i7hjIzoKWa6pch4PcQpthhfSmwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eim0nK9t; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-547bcef2f96so2192088e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741949789; x=1742554589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFKCqYNBypZASUp5pMtBC6KobHZh44HrAoDmtFddJOE=;
        b=Eim0nK9tgYSnKqOJA8OLFaTdQrO9o8RrzmFNRM2XB5Su34bHQf6m2FyGy59pKaZYbT
         xgmGyh0xmlLMMwksSGxpowYtaarZWL2UxiIWMwxmJu00Bzg4fYWZboPZr93ejcuXzr4R
         9OZLI86tZqicNGn0fGEOxXsksAIcudlOpwjRHX7+TNdYwxrtwMzCb6O2RB091RfqEhbe
         1UAFMZHFd/BqSElBakiz+zg1BJFQMULHgpkyP8KCpLHqGNfEPc+iT7/Hu4OIIAOqf4yJ
         9Evrgy9cHDtvCY8E5xc3e2ZV1Lm7mskcefcJ4gwEoEaEFi58vBh5q6UybumAPXRssxUw
         gA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949789; x=1742554589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFKCqYNBypZASUp5pMtBC6KobHZh44HrAoDmtFddJOE=;
        b=fIMC938iSghDWF0wjI9A3XVZDLZDNrRqMs3vELVW6PBeDRpbYVGUxYXD8PWbKCsq9h
         b9qL8fYv0hQqsrNCjqoV8fp7ULlk7/SzJkVQ+mSWmBsHdO/zvtOeyYTMiPs8P/kwoM5W
         vNerAZ7W1lWgY5d7Jm/S5WRualJf/3MchD8xk5hvhz1oU4g93E8DqFLHWbfPfCqQLkcN
         pO0Ek46e844ToZF5AKOKHFOGO6YmMjg8Sl/e2QlynAOiwey/M7vfsXY/RjiJvECf/1sN
         9A3MG+t4B7E4buWWNssqMf9H2n1Aq3zmsG2U4Y0DVTumB1OWUrptqLu5GJ0OZrCM2KPk
         RT6w==
X-Gm-Message-State: AOJu0YxJvzxQwLWizZuCH+J1h/eFMm8RXH4PCYDfsl5zVTZVv75Dn15i
	kplV47xmyKqTOjt+OTOPEuZbjGjZMQPdqPwAjZ1Et5VTOhE9a1XqpHOD9fOex3BYb+EuDPuvzSP
	ITMhsUiI9y3NC+X0uFjGoZCniihJjIKtqCxLa0g==
X-Gm-Gg: ASbGncsnyfzioPppq2KPgdyYqPnO1TDg7IXrOzT9wHNKSWqRytLpzAW3ii7Rnw0Erfi
	inlgt/JM7rS2A3k304OURfjCvzYT++e4u3GZQqKAOSsWlQr0174jTN7lVAYm1T8vQZISzW4kf82
	21bq3mtVn6DdNiMcG/SB+VaUM=
X-Google-Smtp-Source: AGHT+IGMEIctUkZ+4ii44xpSTXwRl6/r0jP4+ihFqaiaUvXraHTiGfWoMgyxvdF+jv3AFKkopYgkDeByxDvDHAoGXN8=
X-Received: by 2002:a05:6512:3d9e:b0:545:2e85:c152 with SMTP id
 2adb3069b0e04-549c3989777mr626075e87.34.1741949788603; Fri, 14 Mar 2025
 03:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313142404.896902416@linutronix.de> <20250313142524.200515896@linutronix.de>
In-Reply-To: <20250313142524.200515896@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:56:17 +0100
X-Gm-Features: AQ5f1JpKpJ8VIbDmqqc7lQAzJRVExumM6FpouAVmjr4gUyzZvasy7vLG9DluGys
Message-ID: <CACRpkdYrEZKqnAh0Zh3s88LGrWPQTJxfSxTjdM7yx8sGtwmHnA@mail.gmail.com>
Subject: Re: [patch 4/7] ARM: orion/gpio:: Convert generic irqchip locking to guard()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Talel Shenhar <talel@amazon.com>, 
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

> Conversion was done with Coccinelle. No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

