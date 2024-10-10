Return-Path: <linux-kernel+bounces-359962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FFD999316
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AADB26A43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211881CBEAB;
	Thu, 10 Oct 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7qwN/G/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAB1CDFD8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589638; cv=none; b=LBuyncw6wvC3rubc7z/Q6FrJ7VHZuNNxh3gMwfk08TUdXaNgsP12CMnOZ/gkG5NuVZrmWP+MoylXWvJPlxa2Xy2aqOyQic3fWJPijsdO5NyfET7sr/2UfaQVToDVS1csaQOWDOlhQhTCprKwfoIj4jbnHh+d2C2s2atOPe78AKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589638; c=relaxed/simple;
	bh=3un/vj/4sEfX8P37x1d7K3WkZBVvttU8+lZQVRD0ezI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDFbkL3zm0W7wwxfjwtbAf2qNTJMW+hdTSyT+k3y3OyYw+dGXl0h8jmzRH1423g1BmUB3he4NBPAacsiQRXQ9xmVbseUPPMuv0YVmllMSfzFtt3qI+OxSIcnjBGhoSanIWCtDqHJIEKmxnrtvLGUPJanlSmkHqXBLipXuweeUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7qwN/G/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fadb636abaso13075501fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728589635; x=1729194435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3un/vj/4sEfX8P37x1d7K3WkZBVvttU8+lZQVRD0ezI=;
        b=g7qwN/G/GSw7zX+zVSbWNf4IJ6iIqJBTqGLe23sIhYuSSapmc5DelxKZorQliQmL94
         TLkVnM3Gkw0UUH3pLr8G8OeSbQ5RnWYXie8PBzq41YncRsCrBhiOCNA3Alytb4001XOt
         RFziEWyOwTJESAbjaG5NSuwezerkwqxNDwMJBtTSIh35ki3IrlNMI7wyc1QlxFLeg+Gy
         kau8QrhadIwS/SGao5M9vSsp4+E9Ly2L0qWkNPR/PHZdP5uieBR5qJ9SR17vh0cDqNks
         byt+MD7XqK8AstGmU1D2ty4wCjpotd9Id0TdBj8yFs1CKtIbSsjfYA5Tbq8XhdUX3FrY
         y+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589635; x=1729194435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3un/vj/4sEfX8P37x1d7K3WkZBVvttU8+lZQVRD0ezI=;
        b=k3nUHWmQx+j/3eXloZD9rJmwxWz+2hR/Dxiy1nXKwesi5YH4D0aKiNBRLTV0fB2bc5
         9ziivvCQCtv9j/uhdzQ0N83W+akbYesx4nbai6eqa44YwFC+7Q3AtS8dTRzbrN96BJjj
         Vy+AFubm2k+BYxcpTjAAgrJR/agtQh7gtyqVgtzGHyY8ZoB7Ca4Vtg/zfFjlVEApXgyp
         sOff64zsr+adGn7okE1UZ20Qkj6W29Gl8Qw9WI+4P5wuvQNlvN5dlo545J76TCML8uAn
         pgBy6oJwKJRBWJPSqri0THx0zWbPxj5WluKdcxEkIihHkkkMNRGOhK8baivfB3OZ76DJ
         CujA==
X-Forwarded-Encrypted: i=1; AJvYcCWpcLkclx6H+P6AFeCos5XctASHtgTW1/CnxaQQqjI6ddyJruIJAtQJSgGviqB/dqtQgDBvhNqzGTSyRog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxifQI/C4ojWIYWpwuYhelnlTRUNWahU8i2uMVZ27V5YmQkgbYY
	0HAXm7tP3Nm/I59P56X7jMPNUKKnfwsYtqEemAyuHCVUPdx0RY7C483vRRCwTD2dxJfBC8ynb2b
	EtbW4eWhis5sDtsUlCHZES0KLgcl2zgeOAM0pRA==
X-Google-Smtp-Source: AGHT+IELYXgxtnHi5qp0nnJFzSpDuWdlKWPCJv0POoV2KfPsuybjMHrLkMQRuc6uPkTZ2s78SWQiLdMpjkPtt5SG9OI=
X-Received: by 2002:a2e:a58b:0:b0:2f5:15f7:7165 with SMTP id
 38308e7fff4ca-2fb2f460bc6mr2991611fa.33.1728589635031; Thu, 10 Oct 2024
 12:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003131642.472298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <7fe863c8-b883-45b0-b0e9-e376764d0bb7@tuxon.dev> <CA+V-a8tQ5vYbzhpdoeBFX483DV-nRpARCdWJnhm-vvTLzpTW2g@mail.gmail.com>
In-Reply-To: <CA+V-a8tQ5vYbzhpdoeBFX483DV-nRpARCdWJnhm-vvTLzpTW2g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 21:47:03 +0200
Message-ID: <CACRpkdak=nv3R4z6PxNEcGgc7B6MV3bjwRbuFoTjgRCQ6CVOXw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Always call rzg2l_gpio_request()
 for interrupt pins
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: claudiu beznea <claudiu.beznea@tuxon.dev>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:27=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Oct 9, 2024 at 9:11=E2=80=AFAM claudiu beznea <claudiu.beznea@tux=
on.dev> wrote:

> > All these ports are hogs to configure them as input. Removing the hog
> > property make this patch work but I'm not sure this is the right approa=
ch
> > (see below diff).
> >
> I have dropped a query [0] to GPIO maintainers to check on the correct ap=
proach.
>
> https://lore.kernel.org/all/CA+V-a8vxUjTWccV-wLgy5CJiFYfEMsx-f+8weCJDP6uD=
_dh4AA@mail.gmail.com/

Yeah I replied, the callbacks in struct irq_chip rzg2l_gpio_irqchip
should be calling the following callbacks:

/* lock/unlock as IRQ */
int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);

In its
.irq_request_resources and .irq_release_resources callbacks.

And it currently doesn't even define these callbacks.

If the driver was using the GPIOLIB_IRQCHIP and adding the
irqchip in the standard way along with the gpiochip, this would
not be a problem.

Can you look into simply using GPIOLIB_IRQCHIP like most
other drivers as well?

Yours,
Linus Walleij

