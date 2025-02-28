Return-Path: <linux-kernel+bounces-537869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6CA491EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3998A1892427
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33638748F;
	Fri, 28 Feb 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgLa4Ayp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E21C3F04
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726655; cv=none; b=Fbr2ha8Gz9ovm7JqsbY08a+6zyPb5dINIFra606xZCMJstyT3+Nm4iMV2NQC3vbqkzIP5qgpJTZOh0xeUHR3j8ElV6/N0W2TgzSEVhwSfkEhEx21WSoibEhc5rkUxwBVrDK384q/EW7p2qbGEindN/j/cbE0lng5QokLGmqfWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726655; c=relaxed/simple;
	bh=e5rDJP51pJSQA9OjMXcqMI2dne8pHRlzXVWljVTaMqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRGaRkMoyF8rb1ov0Zw/ndZobvgMxyKJS1TsoMR8Fvmrf+eff1MR+yOqc7L4MYrsKb9vWf10h58Izh5LzmtJMSrsf6a/etiokxd617QSDM1WcZPoMq3/P7HbvbxieZn3saNNJmR/GuuV0eBJBj+0F4/TOIilHalD/4uH3lRYe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgLa4Ayp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-548878c6a5aso1859938e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740726652; x=1741331452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t8UyiXR6dJzEwnQ10IpflUTVUpmG0RA8RwVK5o31Pc=;
        b=FgLa4AypjRg2k4PGgpJh47iyy/rk+LZMqTTQOFizacfm7rUpLBqAavE78clgPuhZGU
         xu10q/QSArFRNXK5qcHKZYQk+UV3i9jg5T8Lmc+g3g57vo/WN55uttJhSqdWwRlrY69C
         3XbN4252ku/368UI3CHlsLueGumYrC1MGc+ENg352GgepcSHiCi5qI3isbAovPgnd0hV
         JxAGRfmkAUKNzyWRMSgL0iby5h7qXOKvFYRczufhVMAh2H3EusjULuQk+aZIGd+I9R1y
         AkRPgHy4Qyqq+8KeCSWecbreycIwznp+m1ABeJI5DhLZ+H9Zxm1rJ8MCrYRkaSROpuyJ
         NxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740726652; x=1741331452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t8UyiXR6dJzEwnQ10IpflUTVUpmG0RA8RwVK5o31Pc=;
        b=ZO988BbnCOjKs1NTxmbsxe7HX845bKo64s36/xW/JwRRDRTCJmhniSqcqy4Y6NSOZn
         bqY4QgyfAa660coBsCdh/kDYXndXVsBVANDZl3bIyNO8hbM4rQmZPWJIKX4t3LCC4SFB
         c6cqIFGGZrKvvjYC/tGq2GxHL9/DkRujlS+9K9ixkdTVi7mxzzcltgJHLi9X1HpvguB/
         YQcYy99KOKx2cFMgUeOJ48BNsxNF+CQTTN2cYb6gOQjrv7yBnHK9STfhXq2TRRsgzxIE
         VkP9fGWn3CooBzVTZAoZ8mDJhPJjrMujnnb6CpYGQgL/Qv9dgUJq6wtJ1Zrq0/0wonRG
         fN5w==
X-Forwarded-Encrypted: i=1; AJvYcCU/jmHyH15GpP1bWGDLgYlfTGB3wWJymQ3yJpQVqFyemA/wTs7Q9iuBwtzd2H++sfPJJzTyEnrpf2PcUc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFtx+gzlBpOOz9Ra1lMnEBVCl/+gui113TU2oVXFWfY/GD346
	6bm5scGukqhKSfAzdJWp4vq3nXBNy+/GnRp2eD0tJ+fHSsXK585RVappAQNzGyVE3XhVxDjYLJS
	EuehN04ti6ZPs1LC1URp1HSdJSGeO7cpFHGjypA==
X-Gm-Gg: ASbGncv6EStsJh73VAy+UgFE+VzMdGAcWKZMPhN0CfR2ioJCBlYU9wSayUkLOV0tyzY
	bRNyHqvY8LtYmUxWabFBsvuqftsAt7HFvvOKiS+zNigUn8ugWPCy799k1wWNssfls+BDB1EYyOo
	vPuyypPxI=
X-Google-Smtp-Source: AGHT+IEC8EFfAnGhrHuegVK0MjbEHUyO9MnPQrdToy4hgdsyyArn7uO/+zOsNOpafVCwixOTgScGZBK94+hpQYf/RDo=
X-Received: by 2002:ac2:4e14:0:b0:545:93b:30bf with SMTP id
 2adb3069b0e04-5494c37d894mr945955e87.41.1740726651750; Thu, 27 Feb 2025
 23:10:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org> <20250226-max77759-mfd-v2-5-a65ebe2bc0a9@linaro.org>
In-Reply-To: <20250226-max77759-mfd-v2-5-a65ebe2bc0a9@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 08:10:39 +0100
X-Gm-Features: AQ5f1JoHHtaG81ilR6V1iA1OlWE3XjM-gnPRidsiCBk8KODwITMM0tJzyfBKqBU
Message-ID: <CACRpkdYoWuJzjqiKrSNzdXV+5N9Gp0n+pdCwSZgocwy0JHo7Vw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

thanks for your patch!

mostly looks fine, given the MFD design is accepted.
Nitpicks below:

On Wed, Feb 26, 2025 at 6:51=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> +static irqreturn_t max77759_gpio_irqhandler(int irq, void *data)
> +{
> +       int handled =3D 0;

bool handled =3D false;

(...)
> +               for_each_set_bit(offset, &pending, MAX77759_N_GPIOS) {
> +                       unsigned int virq;

I usually just call this "irq", as it's not any more virtual than any other
Linux magic number, and it can confuse people working with
actual virtualization when we call things virtual like this.

> +
> +                       /*
> +                        * ACK interrupt by writing 1 to bit 'offset', al=
l
> +                        * others need to be written as 0. This needs to =
be
> +                        * done unconditionally hence regmap_set_bits() i=
s
> +                        * inappropriate here.
> +                        */
> +                       regmap_write(chip->map, MAX77759_MAXQ_REG_UIC_INT=
1,
> +                                    BIT(offset));
> +
> +                       virq =3D irq_find_mapping(gc->irq.domain, offset)=
;
> +                       handle_nested_irq(virq);
> +
> +                       handled =3D 1;

handled =3D true;

> +       chip->gc.base =3D -1;
> +       chip->gc.label =3D dev_name(&pdev->dev);
> +       chip->gc.parent =3D &pdev->dev;
> +       chip->gc.owner =3D THIS_MODULE;

The core already assigns THIS_MODULE so you can leave it
unassigned.

Yours,
Linus Walleij

