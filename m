Return-Path: <linux-kernel+bounces-538091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090CDA4947B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074671706E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA6254B13;
	Fri, 28 Feb 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCm52MDY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DDD24C689
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733933; cv=none; b=dCVkZNPU60najZTxyA9ur3OJcwqEWltdWR8FNqd0KCzyKqijSjI+45bJnxB3gqE946NScOpbw02ucPi2/hOB0ZgkOSa9lusdOZPZfFQZx7zHhqpvflu9xn9hjFwflTm8b9ebDgV0YLY5m9rT+3tqYo40T4T2UNzA1qb6+jov+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733933; c=relaxed/simple;
	bh=Lwg8wE5Xiedb892k4N/ekZfZJuMIFhCBkPXW1WUwn90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwgXH3uPwn/p1wU00Cy8JWuGO73UZmBOK4+Qutp4yKrss2fDPVJTmfLuPzfMLDF7UFdx3QdcfhbpK0iY5tr8P1dfE0aZQisftlhLRVBERO9R/xupcLkFip+jCq26cAZi1wL+8YkjVtmihDeJl6vRF2pzdCI/NpNgc3E2+ze+Hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCm52MDY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54943bb8006so1952413e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740733928; x=1741338728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8NBOP2GQ2KlGT1kMn03prIoC3D0wUg1PxgjvTKjfnk=;
        b=jCm52MDY3lRencpysUFEtOIzJzW06DiSRahUySDzAU3MInL7SCWmiRZpwKFafcEbYM
         K+PMEzn/BbcgHEXXUUdjfafXq5aV4LA6urKm64vncB2bD9es8Sxs3nH7R0Mbm3Gm2gUF
         J4Xh1FOq5iyh3ddM1/XgwWw71MZfzvGrAtyTs+nMAyFaK/bThWPSiSR9fGigdRG0vLOQ
         PFmBsM+inoB8NxyKwWEH5jBTW8zzSRkKXmdM3y4SMWGPHFl0ONtFCZF6Rr84PIBm6xBK
         iCb/NmRgttNfncI1AOXNuIVNhX0Xsz7OIkx7znlwRk5s0f04BUjWhxmy6Z6EDPCSm2xd
         0QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733928; x=1741338728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8NBOP2GQ2KlGT1kMn03prIoC3D0wUg1PxgjvTKjfnk=;
        b=nCcVNIZyW794yMB7PguVncpzFSeLCIKjFwCzP/5dHnyIShCq7SHFeKoYHGRQWR0kP1
         U/kOx0fDqUnksBV/B/lxcHpAX/5xDGZbmRITAzI0Uj5oh5hLHtJvoSziEUJAwwSrWT6z
         6pXsQhVLo+LHJLnRjFn69rSTogasSmN8xNvpqFqr463zONFQ4/dqn9KhPahaLy9xyTAH
         NO9MadlBvVspKNRCck0uCHvsb9pUgtuausvX4H6i5oS3DR8Ckz6XMoMOy1ZE2unZ/JYH
         +zL74LQQT8NWZviU9wBKU072u9FYYJNPWig53VsPXZa/8TrSypDUmQigCX5go8qqty7B
         mJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfyfEv6FS/ANLP6DyHdehspdVJuQZ73F+ySJYU07UstCIwHj0fZGStmQFJsHzj3CSIvu44yk93J6yJ3aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEPS02Pt8CzZ7DV9bS7tiMQD8wEK0iNGG61dQXEZO9wB47oIz
	KFJ0HJxP0WtIabi5PYPfNDXtq1/NOniN2HtQouBVSEjDwdb98RfT9bsXmmLOLIc9tqdq7xhaQ+v
	FkzgMbzw17bku7uh96UFaRplPN6fkjer7/ynEkw==
X-Gm-Gg: ASbGncsx3kR3yjfYxRkxeuSCXhHbfzwIoP4He1B2nb7JNiEFZnMY8TIuE0fpvlLz5bB
	TPoYOt9jPTbTt8KGpMszbMmeNP2+Yg7mNypHj73WNTs3RD1PakMHTf7caV3lX616pBF7BdvUdum
	qXsXcKKlY=
X-Google-Smtp-Source: AGHT+IFtHDQUwtIkZEmn26SAZGpaLbJ0ZA70JYYMxkjqCpaxYAkU8WvU0gBdbKbqlduqxgwjid1hfQ77kVQK8Hlzc1Q=
X-Received: by 2002:a05:6512:108a:b0:545:2b20:5b21 with SMTP id
 2adb3069b0e04-5494c36869dmr947565e87.50.1740733927813; Fri, 28 Feb 2025
 01:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-04-gpio-irq-threecell-v1-0-4ae4d91baadc@gentoo.org> <20250227-04-gpio-irq-threecell-v1-2-4ae4d91baadc@gentoo.org>
In-Reply-To: <20250227-04-gpio-irq-threecell-v1-2-4ae4d91baadc@gentoo.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 10:11:56 +0100
X-Gm-Features: AQ5f1JrL-KjS4W2cfXdgdW4fA0i_u-8CysEWcjvk-omutRUMfq6vTHu0adnO6VY
Message-ID: <CACRpkdZ1X5kF-AyRBg9BYMiJscv0v-SGzcdetS0XDK3oPSu9QQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: support parsing gpio three-cell interrupts scheme
To: Yixun Lan <dlan@gentoo.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, Alex Elder <elder@riscstar.com>, 
	Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yixun,

thanks for working so hard on this!

I'm really happy to see the threecell support integrated into gpiolib.

On Thu, Feb 27, 2025 at 12:25=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> gpio irq which using three-cell scheme should always call
> instance_match() function to find the correct irqdomain.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> The select() function will be called with !DOMAIN_BUS_ANY,
> kernel/irq/irqdomain.c:556: if (h->ops->select && bus_token !=3D DOMAIN_B=
US_ANY)
>
> so vendor gpio driver need to explicitly set bus_token, something like:
>
> drivers/gpio/gpio-spacemit-k1.c
>   irq_domain_update_bus_token(girq->domain, DOMAIN_BUS_WIRED);
>
> I hope this is a feasible way..

Yes this looks fair, I think you can put the description into the
commit message.

>         /* We support standard DT translation */
> -       if (is_of_node(fwspec->fwnode) && fwspec->param_count =3D=3D 2) {
> +       if (is_of_node(fwspec->fwnode) && fwspec->param_count <=3D 3)
>                 return irq_domain_translate_twocell(d, fwspec, hwirq, typ=
e);
> -       }

This looks good.

> +static int gpiochip_irq_select(struct irq_domain *d, struct irq_fwspec *=
fwspec,
> +                       enum irq_domain_bus_token bus_token)
> +{
> +       struct fwnode_handle *fwnode =3D fwspec->fwnode;
> +       struct gpio_chip *gc =3D d->host_data;
> +       unsigned int index =3D fwspec->param[0];
> +
> +       if ((gc->of_gpio_n_cells =3D=3D 3) && gc->of_node_instance_match)
> +               return gc->of_node_instance_match(gc, index);

We need to hide the OF-specific things into gpiolib-of.c|h so systems
not using OF does not need to see it.

Something like:

if (fwspec->param_count =3D=3D 3) {
     if (is_of_node(fwnode))
         return of_gpiochip_instance_match(gc, index);
    /* Add other threeparam handlers here */
}

Then add of_gpiochip_instance_match() into gpiolib-of.h as a
static inline (no need to an entire extern function...)

static inline bool of_gpiochip_instance_match(struct gpio_chip *gc, int ind=
ex)
{
    if ((gc->of_gpio_n_cells =3D=3D 3) && gc->of_node_instance_match)
              return gc->of_node_instance_match(gc, index);
}

And also an empty stub for !CONFIG_OF_GPIO so we get this compiled
out if OF is not configured in.

Yours,
Linus Walleij

