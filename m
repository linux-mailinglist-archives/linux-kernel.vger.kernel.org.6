Return-Path: <linux-kernel+bounces-401275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C249C1810
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F1284574
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DE61DF723;
	Fri,  8 Nov 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjAlJJWq"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402E1DDC26
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054847; cv=none; b=RHNMDqb1Pp89KfJBmFqrCpcKNQl7BzwUvvdmpE+yb6qG77XHAQxQJ61AGzAsE1YAk3vDTOBs0v8WSgLf0NEUTF+AzW7hlVdyjAhnRq4DbewuxJMC5zo9O4PiZp5QB3n99iQ1tR1vC8yTM2UQoHyB4gUqpGsG9iT6NmLGgmpkrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054847; c=relaxed/simple;
	bh=vVqCqej3UEHzQjSpv0v/eChyYMxhKtzxsLYbfjRtEsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3rYIEgboxGjNyLQnvlSFF30Hv0Q9S24FARgsbk8RbOjUFkJrfDSz6eI9h38X6rWcM2bEtFdWPcUiiPZZRuIRm87/FO82sLN+FjPbLZ7l7DKIgBmyhjasUkIEoJcvSSBCUgS3n9300+Yy7xNd7wxjGY3IWXO1q+ARgkN042FfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xjAlJJWq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb49510250so18317471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054843; x=1731659643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVqCqej3UEHzQjSpv0v/eChyYMxhKtzxsLYbfjRtEsA=;
        b=xjAlJJWqX0HSSNoH6NdsMfiPu44D1spoJUIiT3J3Xp40RiHVFvafLYUmQzldCpIs5D
         WnLruQJJDv7+UlQJemNEYN4CogQZwaani60Ol7k0hz9L1jpCiqzhCMUt02yxVqZrjAoL
         QRJc9r8obpv+vQohZpQKKy+W/l4hvECRujmHRSaB7a5CvyuULcW2ndh75zxjGIrqFLMM
         cOws26E39SCdUPt9DxB8C9s2yPUNByN5aZJBDyyu9xPFGB9LmNWMgkjfCgq5nT4BzNUe
         tN6AHJ94trIAE8KOD1bOB/HHM6PX9KXoOn/I3t9b1wLyZGDzq6wnhRUKnwdFsSUwWaYU
         D6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054843; x=1731659643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVqCqej3UEHzQjSpv0v/eChyYMxhKtzxsLYbfjRtEsA=;
        b=ZuepXGvz/F5pYXsE+8vNMsyWtGreEDeUh2cPo5PDfjSX6C/9AEvd7ANMbh2J/N0JKl
         9ztplaWKh42tEiqH7gfpIfaOLicEbf63Zcju+lkCdtEwF6ip6h7QsJgXUC+aw+vsWKnK
         6CdQoLCxwg5PaSbElzk/6alUCnd69t3FZbBXdtMP6HUI9wV3HekIYPVioshfPDdaTw+k
         CB+voB5Q4AqTZLfIuuX+kcYzfYHKnHk7z40LN9t24JKwJ6lcmDGXu72GYU+ZcCo/t7OL
         +z9PW0dMPKI73BjZHTFPi7Wsk0Gu7Kxe6975iJmVqkeBv/LAEbuOxPX9oGVFuKANaYeX
         C1GA==
X-Forwarded-Encrypted: i=1; AJvYcCU1+u/eLG2as22OB2cAwQnnQ5/2KXiQAb6ZPYa1z5Q5bKfYufuZEOmXzZ8i3+Fq7CtyuAtfTbVP8cXrvd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkSPOJUuRrfVLV1R8LwQusdLcMzeLjgo/ec9YIuqvdZn4V5J1
	lnW9fT2lSEraD4GZhlgFbRpKdL5YeXZS/NTU+nUdpALpExVG8n8wWUModIbzMvktGkt9b8SXimg
	58YMbckobHYAhyRLNUxK9Z9SCWHKF3RFwhSDCeQ==
X-Google-Smtp-Source: AGHT+IGtlBw8/BzKpYwXBVKDarOJwHXN0bQ5Y2Edkm/hG0GzbaUmoWPVA9ksvjdd8kLv/JY3KG1mkk4/qEjDQJYnfQs=
X-Received: by 2002:a2e:be86:0:b0:2fb:59dc:735a with SMTP id
 38308e7fff4ca-2ff2031a659mr7523931fa.41.1731054843501; Fri, 08 Nov 2024
 00:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104093609.156059-1-andriy.shevchenko@linux.intel.com> <20241104093609.156059-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241104093609.156059-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:33:51 +0100
Message-ID: <CACRpkdb2NvL3-+BahUHVWEj+gPKLRmVi3aTrLUSemFoNuj2nmg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] Input: gpio_keys_polled - avoid using GPIOF_ACTIVE_LOW
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

