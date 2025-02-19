Return-Path: <linux-kernel+bounces-522414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A091A3CA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FB817C94F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4153923CF11;
	Wed, 19 Feb 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrC24Sfz"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AC22F167
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997300; cv=none; b=JPDSXGJ3s8go/FffyglAhAr3D2/3i+UXjiOCYL9OuqxZFBEItOUHnYrXpjopZuDXb6Gkp+Ob1ra/MB6LyooAXVlYIVoSythzuYunNdQ5GDU0Kdxke5m0dQhoz4JI45KothO9pWpOjU5a8ggthFRUSuC6jGunjRFOLc7Q47cYdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997300; c=relaxed/simple;
	bh=tmmB1CJeqQfmQIsT1k2GUWvfj10sMcsKlDITNHP0y0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZbf5h4ItgtT9RuACB1+RuQq+5JG2XLYuncSGSHV2/uXxDcB6WT+rI0TbJQH9558uhhlDW0Q45NVD8oQmkKo7y23R2zo6oq8cUvLwYCG+C06Tc3qWdWOoXcayF4wtVag5n4JdBOaCzCq0m2wgQ0irUFeZdz7HYGSisQ21xiFJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrC24Sfz; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso298555e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739997297; x=1740602097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmmB1CJeqQfmQIsT1k2GUWvfj10sMcsKlDITNHP0y0E=;
        b=qrC24SfzifPCd/chsOHEE5eg/ij7+Rqoiy1lfyuVqdpLNT2XMPm4sv1zg+JENjtcal
         9vBYifdKFqZp/DIGw7YhyarKqRZ1g0zwwaO4VAHAnfycUv+bBhsYv+xxFQSUDlQpsvC6
         TLyTBlOGKaBFx26TOsNB+5vTou9SkZTeg7Oibk4/Z0rG2uAMcJbvBG2aYZVh6jnbYnzb
         osVBhY939AitIpz7AaMOFo/QUW/DTtz3yUUsBtOASblJRuwZyEuYVsces0O4uQnJ0nzm
         PC/Jd3yLobueKoVUkyl/20JDTsW4jZpFzRmI2P2MXdS752ZuvXYcoiAs3mfS+QCoyxii
         yIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997297; x=1740602097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmmB1CJeqQfmQIsT1k2GUWvfj10sMcsKlDITNHP0y0E=;
        b=qFpvSTxDkr2EDc8kx5xEenWeKMpcy4M7Sxcb6DydnXagUXSKnZ2ZowCKXKi7R/7m8q
         +lwNAlgZ4qefxcyWUiVa35hy/ojv0a3bo7DpoW4tYmTCwQZGeUcre/4OIW4mH5q4GgFW
         95/PFIsansyCxSdV0pjjxmdLeAMUCiqiA2kLkaRZcSINLD/IDQlSMGHrMWEApzSrgiY2
         yiz5gvwWZF6dzE+upNIExSLdsXv8s7eP2byJV87+TdwZPpmymFAqX78oI79OY7aywyc2
         EiUAV1XGniSiZx1Z50QQq9QA8J85M1FV2z+0c5SbqirHmcU76cuT1u7diho9dG5Dzw5w
         niaA==
X-Forwarded-Encrypted: i=1; AJvYcCUOEJ/vsZ5LObdQ54bInlPr0DaHfJ/qY5Gnerdc49rFp+NzyLHukX+X1Nls3c0D7fRPbyJgHN6wJ+OiOXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHfq0rwQaPUOT5Uc9hkhdvS+KpQDUcD/1/wCH6Ca9KH8jx4r0
	UCsBP32azn7zLjePR83QuLk/IAAQH2bM0mBbZylq7sSYxnuNsmrc2xsjsGiDNDqD72okbT0MpCF
	ghFRAYkzdvyySewuRhL+uFSBstJlPLCCB74LGsw==
X-Gm-Gg: ASbGncvPper8tC3mhYBgsnjnJYDPe+TvVqeeXk4Qae0QzZck/tWTUbaAl4dd/QhSQ+1
	j5zlN77JcPKqtITfeXNJq2UsuZ0+evDY5l3DrTQZfQqPywgPdMPXJsRI3PIIdV4CS/tLRmfX4
X-Google-Smtp-Source: AGHT+IHbToAtZe/z+uRFGIRnNv1BDrEH+lc1qU1hrhcx1euMXlKTWhbbehSpK2l1rH3kiLuqYPFivyA0U+9MmTz7gF8=
X-Received: by 2002:a05:6512:3dab:b0:545:2fcf:642d with SMTP id
 2adb3069b0e04-5452fe2727cmr6277433e87.6.1739997296872; Wed, 19 Feb 2025
 12:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739368121.git.Jonathan.Santos@analog.com> <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
In-Reply-To: <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Feb 2025 21:34:45 +0100
X-Gm-Features: AWEUYZmqmEnkA-aLVYEYk2CgVjDlg2QM-jTEjVJlaUmymL8juT9oZ9shwBapvIM
Message-ID: <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan/Sergiu,

thanks for your patch!

On Wed, Feb 12, 2025 at 7:20=E2=80=AFPM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>
> The AD7768-1 has the ability to control other local hardware (such as gai=
n
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
>
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Is it not possible to use the gpio regmap library in this driver
like we do in drivers/iio/addac/stx104.c?

It cuts down the code size of simple GPIO chips on random
chips quite a lot.

Yours,
Linus Walleij

