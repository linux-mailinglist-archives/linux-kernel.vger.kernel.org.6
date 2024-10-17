Return-Path: <linux-kernel+bounces-369852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D179A2379
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F1C1F276AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5311DE3A5;
	Thu, 17 Oct 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0vQw300"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B91DE88E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171028; cv=none; b=k9nyf+fhOkAmy3nlnm73wDMAytczyTY8FGKU/6Mgc2cp12p9oN1zXNnxVR4a0PwbxWdc2+cNJE2ZAcEVvd4ZLu+Q6IPR8EJuBxybxSNI/29nhunPbf/osP5aBnZe4X1NhuE2uBoxJt1j5ZG+crLLCSDVMxUsTvRecjNeZXtL3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171028; c=relaxed/simple;
	bh=+FOU58zJQWE4kL0vWH8ytXacZQvfJMufhbvS36beHmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiUA9RWcU6iN0/G9PzmP5aa5DdIEOAMU4nSXVk/gWtsHxjIpKCt2OEW7ofVoAUCj/rqgwIybiW9kU8KW7OjXv7siwJp4PGmhNqu/+wP+J10YNWLrPtgkAaJVu9+8is4s8BgJSisxNafjIfr31L3iS2dPLbl+AFdjG3PSOr+WY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N0vQw300; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e5a5abc915so7974577b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729171023; x=1729775823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FOU58zJQWE4kL0vWH8ytXacZQvfJMufhbvS36beHmo=;
        b=N0vQw3007fzZiihqzjouZagMlJYaUotp6whYPAt+VrTd2p0/JA2H6W5Fos8zUjWotC
         iMf8y7dULFmCqPtaTwT+gzfld/wNedFWfB7Ez1zEuFknzBO+ti/mP5/iVO0Lp8KxDcoh
         +7UYGTAZE8y/TKRdl6KYHyI3RggRu8CUT9b0an44ci6LiYaYIQ83eSKOMxfDdIL7IM1p
         8oP8X0Ei0DYVZWDEOwK9yFsqidANdmbfQofCSxu3f+hb1wnuYvYWCqrulQSBymtJeLjg
         yjZlr5by1llNXmX4tJx0YiNqI6wTS9Jeqe8KGCZ+vIIPf2pRWmvQvBx1pEGyD+Gzmbga
         y37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171023; x=1729775823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FOU58zJQWE4kL0vWH8ytXacZQvfJMufhbvS36beHmo=;
        b=pssQ67W3pMezzC61e5F0L7cVeFZFctf27n/gZgdzm4U4yq1iY+HXBDaQ3ql2ux9Dhz
         TV3ITbMdmHvEv1Zd90bxjb84KrqqcyMESq69epXrspgcRfQHkKkrr1TKhd198Hb2nPnA
         0wHH9y8BisgJ8DIcoAYnaiDrxTH3pj86tKTofbd0ZGXz0AeYovgVlwRi0mVFQdPTSS89
         TfVjuFYeVefLWFH/RZfkkjurZI1Jd2olWS76q72vY5GvIAI4GZx6ZHt7tg5UtaMVE1zn
         fmkW80tdenwP9vergR4El85pNYDz7yh7tebfxduRPJRo4LkxGDEsySJOp+FRHA3hbpUG
         bllQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdNbsq9upFrNjDj3OHpIVxStn8H5AG0eQAJRYG+AhNIdXHy9uyJHdZRpGFa6RQRAkEF2SO9511Gg8ylms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl39tRx7yhGsaSdm7+HQOq4akmaR5xhR/40Yp4vuH5g/IquT/o
	Nz49imEOTHUTjIYvC2nswSrOfdRpiZk3AMR1uVlUFOkCBZGicC4/W4r8OB+svYLnCLVADG1nG+x
	XUB6/GH3I2ZV7iv+0BCDvAdWudmOYjw7FomD5ow==
X-Google-Smtp-Source: AGHT+IGjxDp3bd5bTNPAkdchyJmS9HN+k+X/bA52UBE7pZlelsBzyPz7/olzl8FHpN8jiqv9XzPNZ2KYCo+Y021wsx4=
X-Received: by 2002:a05:690c:90:b0:6e3:8760:29b6 with SMTP id
 00721157ae682-6e387602c20mr150562557b3.34.1729171023136; Thu, 17 Oct 2024
 06:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017113942.139712-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20241017113942.139712-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241017113942.139712-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 15:16:50 +0200
Message-ID: <CACRpkdZgWyHfNNu97Wm9F3AZePW-MNy_VLRyxHj402hw7fchCw@mail.gmail.com>
Subject: Re: [PATCH 7/7] pinctrl: renesas: pinctrl-rzg2l: Override irq_request/release_resources
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:39=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Override the default `irq_request_resources` and `irq_release_resources`
> functions with `rzg2l_gpio_irq_request_resources` and
> `rzg2l_gpio_irq_release_resources` in the RZ/G2L pinctrl driver.
>
> The `rzg2l_gpio_irq_request_resources()` function now ensures that the pi=
n
> is requested by the pinctrl core before locking the GPIO as an IRQ. This
> ensures that the `pinmux-pins` file in sysfs correctly reports the pin as
> claimed. Additionally, the `rzg2l_gpio_direction_input()` call is moved
> into the `rzg2l_gpio_irq_request_resources()` callback, as it makes sense
> to configure the GPIO pin as an input after it has been requested.
>
> The `rzg2l_gpio_irq_release_resources()` function unlocks the GPIO as an
> IRQ and then frees the GPIO, ensuring proper cleanup when the IRQ is no
> longer needed. This guarantees that the `pinmux-pins` file in sysfs
> correctly reports the pin as unclaimed.
>
> Also add a `pin_requested()` check in `rzg2l_gpio_free()` to return early
> if the pin is already released.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hm! I can live with this I think, if Geert also think it is the
right thing to do.

Yours,
Linus Walleij

