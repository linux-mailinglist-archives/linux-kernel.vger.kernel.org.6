Return-Path: <linux-kernel+bounces-401263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2DC9C17EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B14B22355
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271041DE8B1;
	Fri,  8 Nov 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ab3PzqSl"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5961DDC26
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054514; cv=none; b=hOhcg9JtjiXmNTuxYmeih7qx4FaLn9eaIV1xmZ+8qNAra5vExJxuogoTFfjbkYlLiBXuQ706tKyx/dUVA54he/b6/iAITzWX8FlNi8fb9OnpzNgRU1dJ/BrFmWfwwDvY74tysUuSYvdx+CvLkkBzEMt7y9yu8vxk4mCi7KiOh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054514; c=relaxed/simple;
	bh=kaMh04+CLb7ZuQdQwd4gSI6K1RpPGQ2X0wWmQyg4vCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQyeTGMmFq9mb5fqA2pX6bpkpzTH74xH5yIgU8ZrQ3i4zMTchu7r88TnmhJXZ47W63Bv1tbikHCnDibPJg2fKvB1PETm9Om0kGD/KLI7njigQHnX+84wYfJtiAF7H4KYJQnaPl4HfDGCfsx6/C74BjDU/1RxJE4ipf/Qe8fnaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ab3PzqSl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53b34ed38easo1742323e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054511; x=1731659311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaMh04+CLb7ZuQdQwd4gSI6K1RpPGQ2X0wWmQyg4vCo=;
        b=ab3PzqSlh+7MVx9YgzYXwyRF5d8Ak1hp++oP0WU6CSdsgOfZLFYwigp8SuUPDYnZv2
         SWB55lgoIWt25cAIEA2sMVBp62vG+a9tKupB6vwwVihCXbr0al2bYlC31s/FXaUKtqh8
         5zNSAE5pgHA+9KHlGR92+NmjKygBBX1hu0hRabxDLTMClpHerk+ah+/DHiyrCQH2jgKe
         ZvGZfjzlNv4OxT5V8V8Ulu8x+6K1BL+fEAwQwe2ieGRGp9dZz2/7fO31ksJGGSU+9JDr
         NjoPhVaLYIXaTNxANlPIqU0/DWqqLOZbjyyf/pZCKi9U/iPCE1Tmlkpk5RxAvNSIlM/8
         nr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054511; x=1731659311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaMh04+CLb7ZuQdQwd4gSI6K1RpPGQ2X0wWmQyg4vCo=;
        b=HTevoZmAfp5kdYobU74c1hb4Wui24EmHZladJ0SwBvt8LTgTIEeSwImyI3GGb24QTJ
         QFNyogmdZdlKqHxR+gt9x6yfH5X2iuDHIgAxzLs7gKuGSFDmHkV/5re1Ks+kMI/BqJ6f
         u8BeFlqfZgV2G6+TNllPrusCW/y+aGgFtaRzA0lYy2SrIyZStr2RuX4Hr+ky9zzJRrVS
         wJ4r7OjPNmUb/09M8KViuUXl1PqF8RV9z6ncmh4nE0pvUskJEyqj02MaZ3GdxvPdZs2b
         L7Ce2MqWgEVQGY4TBgL2X1JRFlVLEWYDjSDQXR1QpWrWWIohEhJteL7M3cF47I+51+eU
         P1TA==
X-Forwarded-Encrypted: i=1; AJvYcCXaTmFj5TIg1AGdB8Fj6aG55yKN28vdxaSj9uFsGBtOLhsfF3Cr3b/L/09nYpz61C2SNGPSXjZakrKP2fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TEGwIDXvjumdD59Q77k53tqb/bs5iKQtNidmhkF2TB9AGZFk
	Leok9hD9pxR08/EEViFTDRcvygP3g+Km+CX3TEEdeel+u0eaiNRZ+Wg2dk0LTUl6j2qkIBqRq+m
	qNZkADsyi7PYxU3CNGHvGt3LV6T6d/0wsWe7u+A==
X-Google-Smtp-Source: AGHT+IG+g9QB/Q7yhaX//JsVe1DFtQNOzLjrFeQ0iseJ97Cr2u/qsa6qFZ/FQqJfsYHVTCRrxZ6pRHR0v/dSmSX5cBg=
X-Received: by 2002:a2e:b8c2:0:b0:2fb:48f6:27e4 with SMTP id
 38308e7fff4ca-2ff2015261amr8351291fa.3.1731054510817; Fri, 08 Nov 2024
 00:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104093609.156059-1-andriy.shevchenko@linux.intel.com> <20241104093609.156059-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241104093609.156059-5-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:28:19 +0100
Message-ID: <CACRpkdYF-_6vb3SsJ9EHh1mCbqeW5=qoYkLF7Re+XyGq36OJSg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] pcmcia: soc_common: Avoid using GPIOF_ACTIVE_LOW
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Avoid using GPIOF_ACTIVE_LOW as it's deprecated and subject to remove.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks right to me, some testing would be even better
because I never trust these flags to get right.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

