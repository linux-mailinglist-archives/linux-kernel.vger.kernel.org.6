Return-Path: <linux-kernel+bounces-362610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642C99B6E2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A867282A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1BB1891B2;
	Sat, 12 Oct 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJVFxTt9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C612C7FB
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728763485; cv=none; b=TTl4tRqYctY9+hLEBMPSXDxmtFTIWLr847ZOp03fucBwcm6X2HXES8H/HTTFxo59Z00Ec9E7Qsp5XPHzI6IpOQpSWwL+ozQ5DU4McceqnKf649Z8yFqXyTxs+JsM3Uly0G9KyrKzqbZqVM7YakU+IXW2CrnKft9eGFUR1UU4wTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728763485; c=relaxed/simple;
	bh=+hwDZaE3yuZt9vzeZthmLQI6V9yR8jL9Lanqpbf5zyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5VsfFVfRqifuxp4s2rBBaWbz7R0RLzkW45KfgYow23vXLG4t8gSNeeqMmeuuUNz3s9+O0/v/o6cOIPxtN8DkF1Ll5RX7C/qYexhNw0LMcQ06rBUuYKfxbm/m+yjQsCydDjnjgSDNHTmy5T24Qd+a7YFVX4vWW+ZflPedctVFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mJVFxTt9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539eb97f26aso222228e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728763482; x=1729368282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ciER1RAhj6UxGN+QOMhjY+VHtJCV5IkRQu/ipXf70g=;
        b=mJVFxTt9ypcfY/K1geBC6yYKPzjTSzU9bxjxUkH9cn4FhA3xUGqjtyPydgZw5OUK7X
         UzqMYF1/LXgPlvpPmV/eJt3VYR7Bqlx908YDAPRj3OTx11LGkZ6WzB0mTqRZmQ3BC5Sv
         iLRNrYVhxyOUjOWVEN2pgdREpGHf1FFocDNe1SLQrfG34rX2VIlt37zfKSfipbB3WtlJ
         NapzrvLymW2ealCBLSCqds3xOr7Q29QeXGhI0VePrK7UJKCf2TUyeVdMGcVp0w/MIh2h
         NwZNo+t0Y0UaMV+l3sAKzplUwnTkxDysLX6d+odIQETGkuZ8W8sffGJKo7RAKdya6kDU
         GoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728763482; x=1729368282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ciER1RAhj6UxGN+QOMhjY+VHtJCV5IkRQu/ipXf70g=;
        b=D+omOU7HRT5KxslCzRoORhf/QYrb1VFTx5g1qrGtNQKQI/WvxhtepQ+sWmJbd08oa/
         HoXnkBP0+yxfkzgWTd1gakc3/fgraJQdq/etPY8OOlc0qtM48qJs3M9efUT9P6P1pgHB
         gJz/EL4hOv2ZXiUSAUV4fUfYqr0aP+XratFtXLrUWtYd5PpbIvqGXaG7MrlvuV9ONLaV
         bXMluoC8l5dsft33RUU4C/Dm5YmdeEb/K6B3gPJNqBlnsA53S5UtFK8eeHKj5UpR6AzA
         qf9MHdE59azeSwgVTfic86sOurWY63ofufuPc+aBUqxeVmx2MF+//3KrFeeXoDVcJsLG
         yIlA==
X-Forwarded-Encrypted: i=1; AJvYcCVCTPi7EpRY7fIom0ZMrivlnUhmP9usPYCAsMu3Te1sNEWc7kYzAMVE+Nl5DZS7fu90AN8Z6bFbzn7ZiyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAVJtdZBCsRoAKr0g59EwKhz3f3zkJqelnmcNeburjBhtwb8V
	LwH/bxHlw4ynNt2jocrfOQ70T/sZuM/WVCR5vd/5ZMyJtOnkrR9P6Yx0LVlxeaVLIADj2rhly0Z
	MYhOgeNBzRUWpgr1MjLoMKvlt+pneoxZFh4Aoyg==
X-Google-Smtp-Source: AGHT+IG/ELgjIgEx+R/BAXvPNIpE0fvyJmngo/5bMIK8gL9M1DCkIU3s9GUQNTn52WN5JfUcGc1E7sPXQ4NdxPfSNRU=
X-Received: by 2002:a05:6512:3da4:b0:539:a3eb:cfff with SMTP id
 2adb3069b0e04-539da5ab2e6mr2914165e87.49.1728763481918; Sat, 12 Oct 2024
 13:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012105743.12450-1-matsievskiysv@gmail.com> <20241012105743.12450-2-matsievskiysv@gmail.com>
In-Reply-To: <20241012105743.12450-2-matsievskiysv@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 12 Oct 2024 22:04:30 +0200
Message-ID: <CACRpkdbCVFEgP3ZchLtM8KgDVVbCiK7ZgGha=iVfTBveRstDkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: ocelot: fix system hang on level based interrupts
To: Sergey Matsievskiy <matsievskiysv@gmail.com>
Cc: alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com, 
	lars.povlsen@microchip.com, horatiu.vultur@microchip.com, 
	andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 12:58=E2=80=AFPM Sergey Matsievskiy
<matsievskiysv@gmail.com> wrote:

> The current implementation only calls chained_irq_enter() and
> chained_irq_exit() if it detects pending interrupts.
>
> ```
> for (i =3D 0; i < info->stride; i++) {
>         uregmap_read(info->map, id_reg + 4 * i, &reg);
>         if (!reg)
>                 continue;
>
>         chained_irq_enter(parent_chip, desc);
> ```
>
> However, in case of GPIO pin configured in level mode and the parent
> controller configured in edge mode, GPIO interrupt might be lowered by th=
e
> hardware. In the result, if the interrupt is short enough, the parent
> interrupt is still pending while the GPIO interrupt is cleared;
> chained_irq_enter() never gets called and the system hangs trying to
> service the parent interrupt.
>
> Moving chained_irq_enter() and chained_irq_exit() outside the for loop
> ensures that they are called even when GPIO interrupt is lowered by the
> hardware.
>
> The similar code with chained_irq_enter() / chained_irq_exit() functions
> wrapping interrupt checking loop may be found in many other drivers:
> ```
> grep -r -A 10 chained_irq_enter drivers/pinctrl
> ```
>
> Signed-off-by: Sergey Matsievskiy <matsievskiysv@gmail.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied and tagged for stable!

Yours,
Linus Walleij

