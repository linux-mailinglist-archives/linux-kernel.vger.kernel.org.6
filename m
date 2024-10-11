Return-Path: <linux-kernel+bounces-361817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D599AD59
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932731F29F39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78C81D0F4F;
	Fri, 11 Oct 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4nqFF63"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAF1D0F4B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676979; cv=none; b=ihDwCLzVzO9qlRbJNaEc5dzZMKvBfQ+JCPF4fm5lz2Lbx9Dk18JUwUwHAlHxhNJHQc8VO++ryp0S8flsC8Tp2FrttjRHX1LlLkAxooBUJbGpDoDSakYw8LWiQaNFxy8Fo+tW3fqeukWPsRYW8n0NRXRF9TCf9yKGesbPeAReqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676979; c=relaxed/simple;
	bh=ODV50fNLCFdjIqcFnpP2PNFAuAzMtDOje2NXbZ7Egzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doX5lhitfH+kdNaGo9uXr8eUd1yykS1QKVMTOoQ0ttAV4MsT8IiiTl8YV+AvQO+FTQiOtkjG+DP5CZBAnHDHCbkX4Pq6BRXyaUpq6dHo59d9YSVAcAG4/AC/obzJnz6ZQlQpfTVDxvUqpcR/183b8VGxEvg3LFluhmEDMFbuNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l4nqFF63; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2667597276.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676976; x=1729281776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SECYkR1tH36IRXjV2hBFD0fayx6FhMErprkUBOQsJ0Q=;
        b=l4nqFF63kCxQXyOrk0xe+vYNuFRT6J0LNqI+ujjIkJDsuuCkGWdiRVxp7P50rS2M+r
         j9J0UTkOufhR1x4t9qMcLdh2z1dD/+5zm3XoOZVp+GKEaxuh4f7DlsnPPDWwF4zPahAO
         LR2J+a5yVD11owkiR/weuoPaWj4uPyUVD+gZ3Lfg6iXldpI4c2bKeEsWfWdLvgAPyR2Z
         TGfdM8urJ8VSZi62cLvHsBGMAoPwIo3w44fyShIA7RbRaZfdMZvJuub5koZ7MXMmTYnH
         H+VcTDJQVkYRwAcpdUuBhcYvsogGxa/ckvvdQ+oFAqcK/P1QjflGMgFUQpzuMCi1/Vze
         aV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676976; x=1729281776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SECYkR1tH36IRXjV2hBFD0fayx6FhMErprkUBOQsJ0Q=;
        b=hByESWijftfNnja16ejwyquygkh6iAkhPHNaGG1dIdB1Rj2CfEfi5fmrF3KE8OulMj
         3uTusGGYP7+Z0KmHDVxl/9ST1xcFyNmNyNroiItj86Cq6Z6RxbHj3JAqjRoQR/w1UpEu
         FzELWJLRGIjUTSOdzc5BeQAJxhXQoL3zIrgo4HDybBvLdc2tI3O+qHVnMoVRY16UQrBP
         woxLXrtJY0MJVOai5NwJ7muhSbGRVavnojHriFrfsJXCgivNWVH1qdtxr4SYqmDkodHn
         mpOjWkxdqMFUPK9WSk63jIemf0xvG9BP5V7bS5hcLyeZkB+RpSXclKFEoUU5Kpz4nkx1
         se1g==
X-Forwarded-Encrypted: i=1; AJvYcCVziAsoJW4opADPOUb6yu22/PTpxAQh61QMoybD9civnLW3/YEjQS8RKDe7924H3zMQB0ie8ZV0BkAlAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfg/U6gAm9EPBtMN3ozSAWBUZOcQYHeYtViVhpogXYxgEaSk2K
	LxQ3VzDpGVLdcAZJmeU+icc7g5O1vRZWHXs2Xesaao85J8qoJKdPgUZVpLr/Lrt4VKrEh5Hy/Rj
	Ni+PBwd0JGVPwugzFfD+py7ArWyJqabgnp+mGyQ==
X-Google-Smtp-Source: AGHT+IEX50nN7GvXdtMOFV2ls3PtiyNs6ga7VtHfFp++1qOGXYlxqaeLTZx/eo82ScV1XRb/2oK53cLuuqtVKJnZo+4=
X-Received: by 2002:a05:690c:4286:b0:6db:4536:85b9 with SMTP id
 00721157ae682-6e3479c297cmr29587547b3.23.1728676976485; Fri, 11 Oct 2024
 13:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006181310.181309-1-matsievskiysv@gmail.com>
 <20241006181310.181309-2-matsievskiysv@gmail.com> <CACRpkdbJ7xh1qOYaZOh+s+Tj_GgE4LXMFuOgL1zpxBRqJQVx6w@mail.gmail.com>
 <ZwlG9AKToZFFPAvi@KILLINGMACHINE>
In-Reply-To: <ZwlG9AKToZFFPAvi@KILLINGMACHINE>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 22:02:44 +0200
Message-ID: <CACRpkdZh_XZOKJa1Ga5vyh3MvY_yb7hDowbuJv-LG47AoZ+UCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: ocelot: fix system hang on level based interrupts
To: Sergey Matsievskiy <matsievskiysv@gmail.com>
Cc: alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com, 
	lars.povlsen@microchip.com, horatiu.vultur@microchip.com, 
	andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 5:40=E2=80=AFPM Sergey Matsievskiy
<matsievskiysv@gmail.com> wrote:
> On Fri, Oct 11, 2024 at 11:18:55AM +0200, Linus Walleij wrote:

> > I'm a bit puzzled by the patch because I don't understand it.
>
> The current implementation only calls chained_irq_enter() and chained_irq=
_exit()
> if it detects pending interrupts.
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
> However, in case of GPIO pin configured in level mode and the parent cont=
roller
> configured in edge mode, GPIO interrupt might be lowered by the hardware.=
 In the
> result,if the interrupt is short enough, the parent interrupt is still pe=
nding
> while the GPIO interrupt is cleared; chained_irq_enter() never gets calle=
d and
> the system hangs trying to service the parent interrupt.
>
> Moving chained_irq_enter() and chained_irq_exit() outside the for loop en=
sures
> that they are called even when GPIO interrupt is lowered by the hardware.
>
> The similar code with chained_irq_enter() / chained_irq_exit() functions
> wrapping interrupt checking loop may be found in many other drivers:
> ```
> grep -r -A 10 chained_irq_enter drivers/pinctrl
> ```
>
> > This needs to describe how moving the chained irq calls achieves
> > this effect.
>
> If the explanation above satisfies you, I'll elaborate the commit message=
 and
> resend the patch.

Excellent explanation Sergey, just put it all in the committ message
and I'll apply it!

Yours,
Linus Walleij

