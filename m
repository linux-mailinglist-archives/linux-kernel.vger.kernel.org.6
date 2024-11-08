Return-Path: <linux-kernel+bounces-401276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EB9C1815
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A571C21E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94591DF753;
	Fri,  8 Nov 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDwgzitj"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285C1DE899
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054877; cv=none; b=mSz4du2/uYVc3qfO/UH0vxQiWLgkOcQEsLkmG/yoi0QQqdIDAl9xtUcVfFfENdcSiYUFtEBcEbQ3DII5JwgAYj1wUnGAYmGZjl9QOEgNTNC6cZkZnvu3D8ESVBQMh10EqisoghmfWe1MA7ZTW5wJ6UlSifUgrfhE7gN1oERF7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054877; c=relaxed/simple;
	bh=m9K+9SzWuLqo1fVpHFezCjov3Z+u1nFxQFcoG02nQW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbAc5i1O4fr91fLygy+5NVHxOXvb59Gl3kW+E5q5o7RyUqakYN1USjMjo5YLPUAvVta0hVOc7AaZR0qQRDfeZUCN3L7ouKXZFkFaY3+qAc5Y9bJAytGcyvCXQO/+0k23w9MXexDZfCZCdYcuApYWjTBbn9oCuSZSaF/0yqaieUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aDwgzitj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so16424271fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054873; x=1731659673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9K+9SzWuLqo1fVpHFezCjov3Z+u1nFxQFcoG02nQW0=;
        b=aDwgzitjyirX0jfR/DSNwos9ZnkUVJ7ZTgdXUcb3X0YnrIrTeUPlDgmy22bQxvTZDv
         WQAelVSxAdMmnzYPwwWrTZQkRWncJ7zUyjBfi+/VBiWH5SjQI+CMEpS8X1SUlsNuk2ax
         qcdyKmSZ/X9oG7ph9zEphqgzCDjVUL9h6DipVhM4xwbE1MjSZy4q3vmMIJIkorXDB5Ls
         N5WzTZsPeW0ptZnLqGWhT2uAhKYousBH7RtRPoAPunn0Ps4OeLJhUgr0bZYlj5EVz5Bs
         Ea9GwO6o1InpZkEK4B0Bbvh2OeqA2T6ri0RtzZQmek0HfqbMVg8X2Z+bg29HWYOSdvp5
         cRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054873; x=1731659673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9K+9SzWuLqo1fVpHFezCjov3Z+u1nFxQFcoG02nQW0=;
        b=sXycw4jMzW2GBkEMU4C9U9Pq9RlxAZhE+PIg2/IB4ebKJl4vN8TJp1OW4dDBZracc5
         6r91TOm6MUrM9yZc/Hce/EXdvcLX/WmFfebk1YZdnvGz1JleOpf3JPFkj3XDvYG8/dDy
         jy2V+lQg1Y+IYstOOtOADLkpSybx8okIVIpPWP4Z+3aGH2iQjsjKyc4kp2AUbzmyNk4/
         YrU3hX0xcMktvKZBinEctIbLO0uge2WKQriRr03W+goKTOnSm37QA8iRO+Kqci51BfiB
         yses+6iWkUExF+5JDmkTNnXhKIC84WRMZKzmYMYkMjWhCW6hMYGBbFQSBRfAr1McoaCQ
         b6MA==
X-Forwarded-Encrypted: i=1; AJvYcCVVPfKhTLM2eH3Hj/EpYavri1p7HGuM928/RxcZUvwKBS5IPIF3p9Yz4lTM4cNoz4d/ZJ5lYfGZmm+oYws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UAmYX/gQxa4qwh72WyCw2IR0QzwQbE5vwsMDY6I16VgHclhB
	0OS+itufyKzG+iphpbhqZGHuKjhtrAK1T8uRnScyksyzWbKVDJivz/ETXdlPetY9EtspHL+rJTb
	TsQA/QLi2L/aWa6dn1l7p+b5/vThwT3TuTD/5ZQ==
X-Google-Smtp-Source: AGHT+IHx7mAPhJnzxE7EYgyRjyP79PfLYtwkdmgWKx0QpJkHxCqAuAqQZIcNr65Vl/TTpb1mgGDc7xzfzo1LsoeLK4Y=
X-Received: by 2002:a2e:a98c:0:b0:2f7:a759:72a7 with SMTP id
 38308e7fff4ca-2ff2016dabfmr8041491fa.22.1731054873529; Fri, 08 Nov 2024
 00:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104093609.156059-1-andriy.shevchenko@linux.intel.com> <20241104093609.156059-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241104093609.156059-6-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:34:22 +0100
Message-ID: <CACRpkdZ6gYfbkjcWMNOOyN9owg8n6ApFVv5XZXUA2CY4-JXOVw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] USB: gadget: pxa27x_udc: Avoid using GPIOF_ACTIVE_LOW
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

